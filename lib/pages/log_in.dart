// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:metrical/main/homepage.dart';
import 'package:metrical/main/stats.dart';
import 'package:metrical/pages/create_account.dart';
import 'package:metrical/services/supabase_auth.dart';
import 'package:metrical/states/states.dart';
import 'package:metrical/utils/dump.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In with your Account'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Hello!, Please Log In',
                style: TextStyle(fontSize: 24),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  final email = emailController;
                  final password = passwordController;

                  try {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      if (mounted) {
                        States.instance.showtheSnackbar(
                            title: 'Email and Password form field is empty!');
                      }
                    } else {
                      await SupabaseAuth.instance
                          .signIn(email.text.trim(), password.text.trim());
                      States.instance.showtheSnackbar(
                          title: 'Logged In Successfully!',
                          duration: 5,
                          color: yellowScheme);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (cotnext) => const Homepage(),
                        ),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error logging in at => $e')));
                    }
                  }
                },
                child: const Text('Log In'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: const Color.fromARGB(255, 147, 147, 147),
                      height: 10,
                      thickness: 1,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    'OR',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: const Color.fromARGB(255, 147, 147, 147),
                      height: 10,
                      thickness: 1,
                      indent: 10,
                    ),
                  ),
                ],
              ),
              Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /*
                    
                    Google button
                    
                    */
                    GestureDetector(
                      onTap: () async {
                        try {
                          SupabaseAuth.instance.signInWithGoogle();
                        } catch (e) {
                          print('Error during sign-in: $e');
                        }
                      },
                      child: Container(
                        //margin: const EdgeInsets.only(right: 10),
                        child: Image.asset(
                          'assets/images/google_icon.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    /*
                    
                    Facebook button
                    
                    */
                    GestureDetector(
                      onTap: () async {
                        try {
                          final supabase = Supabase.instance.client;

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Working on it!')));
                        } catch (e) {
                          print('Error during sign-in: $e');
                        }
                      },
                      child: Container(
                        //margin: const EdgeInsets.only(right: 10),
                        child: Image.asset(
                          'assets/images/facebook_icon.png',
                          width: 37,
                          height: 45,
                        ),
                      ),
                    ),
                  ]),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const CreateAccount();
                  }));
                },
                child: const Text(
                  '\nDon\'t have an account?',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
