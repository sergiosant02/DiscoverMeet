import 'package:discover_meet/src/connections/room_connection.dart';
import 'package:discover_meet/src/utils/interface_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/page_provider.dart';
import '../utils/interface_elements.dart';

class AppBarDiscover {
  const AppBarDiscover();

  static PreferredSizeWidget build(BuildContext context, bool showSearch,
      {bool showBackButton = true}) {
    String roomCode = '';
    final PageProvider pageProvider = Provider.of<PageProvider>(context);
    RoomConnection roomConnection = RoomConnection();
    final formKey = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size;
    return AppBar(
      automaticallyImplyLeading: showBackButton,
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: false,
      title: const Text(
        'Discover meet',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: const Color.fromRGBO(63, 35, 5, 1),
      actions: [
        showSearch
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => InterfaceColors.backgroundColor)),
                    label: const Text(
                      'Buscar sala',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Form(
                                key: formKey,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  height: 200,
                                  width: size.shortestSide * 0.8,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  child: Column(children: [
                                    const Text(
                                      'Buscador de salas',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(child: Container()),
                                    TextFormField(
                                      initialValue: roomCode,
                                      onChanged: (value) => roomCode = value,
                                      decoration: const InputDecoration(
                                          hintText:
                                              'Escriba su código de sala'),
                                      validator: (value) {
                                        if (value != null && value.isEmpty) {
                                          return "Debe introducir un código";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Spacer(),
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
                                              if (formKey.currentState!
                                                  .validate()) {
                                                Navigator.pop(context);
                                                context.replace('/');
                                                await roomConnection
                                                    .joinToRoom(roomCode);
                                                pageProvider.page = 0;
                                              }
                                            },
                                            child: const Text('Buscar'))
                                      ],
                                    )
                                  ]),
                                ),
                              ),
                            );
                          });
                    },
                    icon: InterfaceElements.searchIconBlack),
              )
            : Container()
      ],
    );
  }
}
