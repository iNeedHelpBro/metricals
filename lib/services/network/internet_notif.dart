import 'package:flutter/material.dart';

class InternetNotif extends StatelessWidget {
  const InternetNotif({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Icon(
              Icons.network_wifi,
              size: 50,
            ),
            Text(
              'No Internet Connecttion\nCheck your network and try again',
              style:
                  TextStyle(color: Colors.lightGreenAccent[700], fontSize: 40),
            )
          ],
        ),
      ),
    );
  }
}
