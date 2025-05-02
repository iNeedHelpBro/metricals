// ignore_for_file: prefer_const_constructors

import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:metrical/main/menu_page.dart';
import 'package:metrical/main/stats.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentPage = 0;

  List<Widget> pages = [Stats(), MenuPage()];
  List<TabItem> items = [
    TabItem(
      icon: Icons.pie_chart,
      title: 'Statistics',
    ),
    TabItem(
      icon: Icons.fastfood,
      title: 'Menu',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: const Color.fromARGB(192, 230, 250, 255),
        body: IndexedStack(
          index: currentPage,
          children: pages,
        ),
        bottomNavigationBar: BottomBarInspiredOutside(
          items: items,
          backgroundColor: Colors.white,
          color: Colors.deepPurple,
          colorSelected: Colors.white,
          indexSelected: currentPage,
          onTap: (int index) => setState(() {
            currentPage = index;
          }),
          top: -25,
          animated: true,
          itemStyle: ItemStyle.hexagon,
          chipStyle: const ChipStyle(drawHexagon: true),
        ),
        // BottomNavigationBar(
        //   iconSize: 35,
        //   selectedFontSize: 0,
        //   unselectedFontSize: 0,
        //   onTap: (value) {
        //     setState(() {
        //       currentPage = value;
        //     });
        //   },
        //   currentIndex: currentPage,
        //   items: const [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.pie_chart),
        //       label: '',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.fastfood),
        //       label: '',
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
