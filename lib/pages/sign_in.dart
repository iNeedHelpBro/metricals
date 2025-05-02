import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:metrical/components/my_button.dart';
import 'package:metrical/pages/create_account.dart';
import 'package:metrical/pages/log_in.dart';
import 'package:metrical/services/auth_signin.dart';
import 'package:metrical/services/auth_stats.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Choose where to sign in from!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Google button
                  MyButton(
                    onPressed: () async {
                      try {
                        final supabase = Supabase.instance.client;

                        if (kIsWeb) {
                          await supabase.auth
                              .signInWithOAuth(OAuthProvider.google);
                        } else if (Platform.isIOS) {
                          await supabase.auth
                              .signInWithOAuth(OAuthProvider.apple);
                        } else if (Platform.isAndroid) {
                          AuthSignin.instance.googleSignIn();
                        } else {
                          print('Unsupported platform');
                        }
                      } catch (e) {
                        print('Error during sign-in: $e');
                      }
                    },
                    label: Image.asset('assets/images/google.png',
                        width: 30, height: 30),
                  ),
                  //Login
                  MyButton(
                    onPressed: () async {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => const AuthStats(),
                      );

                      Navigator.push(context, route);
                    },
                    label: Image.asset('assets/images/log-in.png',
                        width: 30, height: 30),
                  ),
                  //Register
                  MyButton(
                    onPressed: () {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => const CreateAccount(),
                      );

                      Navigator.push(context, route);
                    },
                    label: Image.asset('assets/images/register.png',
                        fit: BoxFit.fitHeight, width: 30, height: 30),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
