import 'package:flutter/material.dart';
import 'package:newsapp/view/categories_screen.dart';
import 'package:newsapp/view/home_screen.dart';
import 'package:newsapp/view/search_screen.dart';

import '../helpers/Constant.dart';


class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    SearchScreen(),
    CategoriesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: Constant.bottomNavigationHome,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: Constant.bottomNavigationSearch,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: Constant.bottomNavigationCategories,
          ),
        ],
      ),
    );
  }
}
