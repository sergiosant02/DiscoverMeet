// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer' as dev;

import 'package:discover_meet/main.dart';
import 'package:discover_meet/src/connections/room_connection.dart';
import 'package:discover_meet/src/custom_widgets/app_bar_discover.dart';
import 'package:discover_meet/src/pages/Room/my_room_list_page.dart';
import 'package:discover_meet/src/pages/Room/room_list_page.dart';
import 'package:discover_meet/src/pages/UserPage/login_page.dart';
import 'package:discover_meet/src/pages/UserPage/user_page.dart';
import 'package:discover_meet/src/providers/page_provider.dart';
import 'package:discover_meet/src/utils/interface_colors.dart';
import 'package:discover_meet/src/utils/interface_elements.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    final PageProvider _pageProvider = Provider.of<PageProvider>(context);
    return Scaffold(
        appBar: AppBarDiscover.build(context, true),
        bottomNavigationBar: BottomNavigationBar(
            fixedColor: InterfaceColors.principalColor,
            items: InterfaceElements.itemNavigation,
            backgroundColor: InterfaceColors.menuColor,
            currentIndex: _pageProvider.page,
            onTap: (value) => _pageProvider.page = value),
        backgroundColor: InterfaceColors.backgroundColor,
        body: choosePage(_pageProvider.page));
  }

  Widget choosePage(int page) {
    Widget result;
    if (pref.token != '') {
      switch (page) {
        case 0:
          result = const RoomListPage();
          break;
        case 1:
          result = const MyRoomListPage();
          break;
        default:
          result = const UserPage();
      }
    } else {
      result = const LoginPage();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 3.0, left: 15, right: 15, bottom: 3),
      child: result,
    );
  }
}
