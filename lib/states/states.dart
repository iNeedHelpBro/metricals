import 'package:flutter/material.dart';

final snackbar = GlobalKey<ScaffoldMessengerState>();

class States {
  static States instance = States();

  void gotoWithSnackbar(String title, int duration) {
    snackbar.currentState?.showSnackBar(
      SnackBar(
        duration: Duration(seconds: duration),
        content: Text(title),
      ),
    );
  }
}
