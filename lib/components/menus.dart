import 'package:flutter/material.dart';
import 'package:metrical/utils/dump.dart';

class Menus extends StatelessWidget {
  final String title;
  final String mealDescription;
  final String image;
  const Menus({
    super.key,
    required this.title,
    required this.mealDescription,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 219, 208, 175),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 5),
          Text(
            mealDescription,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 25),
          Expanded(
            child: Center(
              child: Image.network(
                image,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
