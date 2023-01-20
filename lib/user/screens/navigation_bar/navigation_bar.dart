import 'package:flutter/material.dart';

import '../home_screen/home_screen.dart';
import '../lecture_screen/lecture_screen.dart';
import '../lets_grow_screen/lets_grow_screen.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    LecturesScreen(),
    LetsGrowScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.play_circle_fill), label: 'Lectures'),
            BottomNavigationBarItem(
                icon: Icon(Icons.upcoming), label: 'Lets Grow together'),
          ],
        ),
      ),
    );
  }
}
