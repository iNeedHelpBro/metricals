import 'package:flutter/material.dart';
import 'package:metrical/main/homepage.dart';
import 'package:metrical/pages/create_account.dart';
import 'package:metrical/states/states.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final email = TextEditingController();
  final password = TextEditingController();
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
                controller: email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: password,
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
                  try {
                    final supabase_login = Supabase.instance.client;

                    final response =
                        await supabase_login.auth.signInWithPassword(
                      email: email.text,
                      password: password.text,
                    );

                    if (response.user != null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const Homepage();
                      }));
                      States.instance.gotoWithSnackbar(
                        'Login successful',
                        2,
                      );
                      setState(() {
                        email.clear();
                        password.clear();
                      });
                    } else if (response.session == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Login failed: No session returned')),
                      );
                    } else if (email.text.isEmpty || password.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please provide credentials!')),
                      );
                    }
                  } catch (e) {
                    print('Error during sign-in: $e');
                  }
                },
                child: const Text('Log In'),
              ),
              const SizedBox(height: 20),
              Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),
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
