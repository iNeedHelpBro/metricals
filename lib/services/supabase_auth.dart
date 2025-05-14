// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'package:metrical/main/homepage.dart';
import 'package:metrical/services/auth_signin.dart';
import 'package:metrical/states/states.dart';
import 'package:metrical/utils/dump.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuth {
  final supabase_client = Supabase.instance.client;

  static SupabaseAuth instance = SupabaseAuth();

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://nvzfhsjifezuqwozlfgz.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im52emZoc2ppZmV6dXF3b3psZmd6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQzNTIwOTMsImV4cCI6MjA1OTkyODA5M30.mk3bda2paHR8UdjEqSUH97nRO4dA48NdvWw6xYmnrs4',
    );
  }

  /*
  supabase getter
  */
  static SupabaseClient get client => Supabase.instance.client;

  Future<void> createAccountWithGoogle(BuildContext context) async {
    loadingDialog().then((val) async {
      EasyLoading.dismiss();
      try {
        final response = await supabase_client.auth.signInWithOAuth(
            OAuthProvider.google,
            redirectTo: 'com.example.metrical://login-callback');

        if (response == true) {
          States.instance.showtheSnackbar(title: 'Account Created!');
        }
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                surfaceTintColor: Colors.black38,
                elevation: 15,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Something went wrong with your account',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Lottie.asset('assets/animations/error_ani.json',
                          fit: BoxFit.fill, height: 170, width: 180),
                      //Icon(Icons.check_circle, color: Colors.green, size: 70),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Click Anywhere to continue',
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                ),
              );
            });
      }
    });
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final response = await AuthSignin.instance.googleSignIn();

      if (response.session != null) {
        States.instance.showtheSnackbar(
            title: 'Logged In Successfully!', duration: 5, color: yellowScheme);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Google Sign-In failed. Please try again.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In Error: $e')),
      );
    }
  }

/*

Signing with user's account

*/
  Future<AuthResponse> signIn(String email, String password) async {
    return await supabase_client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

/*

Creating account

*/
  Future<AuthResponse> signUp(String email, String password) async {
    return await supabase_client.auth.signUp(
      email: email,
      password: password,
    );
  }

/*

Logout account

*/
  Future<void> signOut() async {
    await supabase_client.auth.signOut();
  }

/*

Get users account details

*/
  String? getCurrentUser() {
    final session = supabase_client.auth.currentSession;
    final user = session?.user;

    return cutTo(user?.email);
  }
}
/*

START WORKING FOR ADMIN SIDE PANEL

*/