import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuth {
  final supabase_client = Supabase.instance.client;

  static final SupabaseAuth instance = SupabaseAuth();
  Future<AuthResponse> signIn(String email, String password) async {
    return await supabase_client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUp(String email, String password) async {
    return await supabase_client.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await supabase_client.auth.signOut();
  }

  String? getCurrentUser() {
    final session = supabase_client.auth.currentSession;
    final user = session?.user;

    return user?.email;
  }
}
