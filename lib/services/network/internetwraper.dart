// ignore_for_file: unrelated_type_equality_checks

import 'package:connectivity_plus/connectivity_plus.dart';
import 'internet_notif.dart';
import 'package:flutter/widgets.dart';

class Internetwraper extends StatefulWidget {
  Widget child;
  Internetwraper({super.key, required this.child});

  @override
  State<Internetwraper> createState() => _InternetwraperState();
}

class _InternetwraperState extends State<Internetwraper> {
  bool hasInternet = true;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((s) {
      setState(() {
        hasInternet = s != ConnectivityResult.none;
      });
    });

    Connectivity().checkConnectivity().then((s) {
      setState(() {
        hasInternet = s != ConnectivityResult.none;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return hasInternet ? widget.child : const InternetNotif();
  }
}
