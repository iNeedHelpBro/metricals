// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:metrical/main/homepage.dart';
import 'package:metrical/pages/log_in.dart';
import 'package:metrical/services/auth_signin.dart';
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
                    //Google button
                    GestureDetector(
                      onTap: () async {
                        try {
                          final supabase = Supabase.instance.client;

                          if (kIsWeb) {
                            await supabase.auth
                                .signInWithOAuth(OAuthProvider.google);
                          } else if (Platform.isAndroid) {
                            AuthSignin.instance.googleSignIn();
                          } else {
                            print('Unsupported platform');
                          }
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
                    //Facebook button
                    GestureDetector(
                      onTap: () async {
                        try {
                          final supabase = Supabase.instance.client;

                          if (kIsWeb) {
                            await supabase.auth
                                .signInWithOAuth(OAuthProvider.facebook);
                          } else if (Platform.isAndroid) {
                            await supabase.auth.signInWithOAuth(
                              OAuthProvider.facebook,
                              redirectTo: kIsWeb
                                  ? 'https://nvzfhsjifezuqwozlfgz.supabase.co/auth/v1/callback'
                                  : 'io.supabase.flutterdemo://login-callback',
                            );
                          } else {
                            print('Unsupported platform');
                          }
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
                    return const LogIn();
                  }));
                },
                child: const Text(
                  '\nAlready Created an Account? Log In Here!',
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
