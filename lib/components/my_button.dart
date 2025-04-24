import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget label;
  const MyButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.inversePrimary,
      textColor: Colors.white,
      padding: const EdgeInsets.all(14.0),
      shape: ContinuousRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2.0,
        ),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20.0),
          bottom: Radius.circular(20.0),
        ),
      ),
      child: label,
    );
  }
}
