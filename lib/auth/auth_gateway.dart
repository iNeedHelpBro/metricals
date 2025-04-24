import 'package:flutter/material.dart';
import 'package:metrical/main/homepage.dart';
import 'package:metrical/pages/create_account.dart';
import 'package:metrical/pages/sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGateway extends StatelessWidget {
  const AuthGateway({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snaps) {
          if (snaps.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final session = snaps.hasData ? snaps.data!.session : null;

          if (session != null) {
            return const Homepage();
          }
          return const CreateAccount();
        });
  }
}
