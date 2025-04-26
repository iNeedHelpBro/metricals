// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:metrical/components/my_button.dart';
import 'package:metrical/pages/sign_in.dart';
import 'package:metrical/provider/menu_provider.dart';
import 'package:metrical/states/states.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://nvzfhsjifezuqwozlfgz.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im52emZoc2ppZmV6dXF3b3psZmd6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQzNTIwOTMsImV4cCI6MjA1OTkyODA5M30.mk3bda2paHR8UdjEqSUH97nRO4dA48NdvWw6xYmnrs4',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuProvider()),
      ],
      child: MaterialApp(
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: snackbar,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'MetriCal'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void signInPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignIn(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Going to the Sign In page',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              MyButton(
                onPressed: signInPage,
                label: Text('Sign In Now!'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
