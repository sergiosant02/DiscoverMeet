// ignore_for_file: no_leading_underscores_for_local_identifiers


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
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final _formKey = GlobalKey<FormState>();
  RoomConnection roomConnection = RoomConnection();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final PageProvider _pageProvider = Provider.of<PageProvider>(context);
    return Scaffold(
        floatingActionButton: (_pageProvider.page == 1 && pref.token != "")
            ? optionsRoomPersonal(context, size)
            : null,
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

  Widget optionsRoomPersonal(BuildContext context, Size size) {
    final PageProvider _pageProvider = Provider.of<PageProvider>(context);
    String roomName = "";
    return Container(
      margin: const EdgeInsets.only(left: 25),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            key: UniqueKey(),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: InterfaceColors.principalColor,
            label: const Text(
              "Crear sala",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        height: 200,
                        width: size.shortestSide * 0.8,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const Text("Crear una sala",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Expanded(child: Container()),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: "Nombre de la sala"),
                                onChanged: (value) {
                                  roomName = value;
                                },
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return "Debe introducir un código";
                                  }
                                  return null;
                                },
                              ),
                              Expanded(child: Container()),
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        context.pop(context);
                                      },
                                      child: const Text('Cancelar')),
                                  const Spacer(),
                                  TextButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          Navigator.pop(context);
                                          context.replace("/");
                                          await roomConnection
                                              .createRoom(roomName);
                                          _pageProvider.page = 0;
                                        }
                                      },
                                      child: const Text('Crear'))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
          ),
          const Spacer(),
          FloatingActionButton.extended(
              backgroundColor: InterfaceColors.principalColor,
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
              label: const Text(
                "Buscar mi sala",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
