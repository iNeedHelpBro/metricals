// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:metrical/provider/menu_provider.dart';
import 'package:metrical/services/auth_stats.dart';
import 'package:metrical/services/network/internetwraper.dart';
import 'package:metrical/services/supabase_auth.dart';
import 'package:metrical/states/states.dart';
import 'package:provider/provider.dart';
import 'package:uni_links5/uni_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SupabaseAuth.initialize();
  urlDeepLink();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuProvider()),
      ],
      child: Internetwraper(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      scaffoldMessengerKey: snackbar,
      title: 'MetriCal App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: AuthStats(),
    );
  }
}

void urlDeepLink() {
  uriLinkStream.listen((data) {
    if (data != null) {
      SupabaseAuth.client.auth.getSessionFromUrl(data);
    }
  });
}
