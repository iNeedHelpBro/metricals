import 'package:flutter/material.dart';
import 'package:metrical/services/supabase_auth.dart';

class ProfileSettingPage extends StatefulWidget {
  const ProfileSettingPage({super.key});

  @override
  State<ProfileSettingPage> createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
  final user = SupabaseAuth.instance.getCurrentUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Name: $user'),
      ),
    );
  }
}
