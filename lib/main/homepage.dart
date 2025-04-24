// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:metrical/main/menu_page.dart';
import 'package:metrical/main/stats.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentPage = 0;

  List<Widget> pages = [Stats(), MenuPage()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: const Color.fromARGB(192, 230, 250, 255),
        body: IndexedStack(
          index: currentPage,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 35,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          onTap: (value) {
            setState(() {
              currentPage = value;
            });
          },
          currentIndex: currentPage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fastfood),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
