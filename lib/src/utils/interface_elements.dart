import 'package:flutter/material.dart';

class InterfaceElements {
  static Color principalColor = const Color.fromRGBO(63, 35, 5, 1);
  static Color backColor = const Color.fromRGBO(242, 234, 211, 1);

  static List<BottomNavigationBarItem> itemNavigation = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Home',
        activeIcon: Icon(
          Icons.home,
          color: Color.fromRGBO(63, 35, 5, 1),
        )),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.person_pin,
        ),
        activeIcon: Icon(Icons.person_pin, color: Color.fromRGBO(63, 35, 5, 1)),
        label: 'Usuario')
  ];
  static Icon searchIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );
}
