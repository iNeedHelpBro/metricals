import 'package:flutter/material.dart';
import 'package:metrical/main/homepage.dart';
import 'package:metrical/pages/log_in.dart';
import 'package:metrical/states/states.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String uId = '';
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
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
                'Create Account',
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
                  final emailText = email.text;
                  final passwordText = password.text;

                  try {
                    final signup = await Supabase.instance.client.auth.signUp(
                      email: emailText,
                      password: passwordText,
                    );
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const LogIn();
                    }));
                    States.instance.gotoWithSnackbar(
                      'Account Created Successfully',
                      2,
                    );

                    setState(() {
                      email.clear();
                      password.clear();
                      uId = signup.user?.id ?? emailText.substring(0, 5);
                    });
                  } catch (_) {
                    print(_);
                  }
                },
                child: const Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
