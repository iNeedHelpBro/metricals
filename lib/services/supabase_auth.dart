import 'package:metrical/services/auth_signin.dart';
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

  Future<void> signInWithGoogle() async {
    try {
      AuthSignin.instance.googleSignIn();
    } catch (e) {
      print("Google Sign-In Error: $e");
    }
  }

/*

Creating an account

*/
  Future<AuthResponse> signIn(String email, String password) async {
    return await supabase_client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

/*

Signing account

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
