// ignore_for_file: unused_field

import 'package:discover_meet/src/connections/room_connection.dart';
import 'package:discover_meet/src/models/room_model.dart';
import 'package:discover_meet/src/providers/page_provider.dart';
import 'package:discover_meet/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyRoomWidget extends StatelessWidget {
  final RoomModel roomModel;
  final Function() onTap;
  MyRoomWidget({
    Key? key,
    required this.roomModel,
    required this.onTap,
  }) : super(key: key);
  final RoomConnection _roomConnection = RoomConnection();
  final _formKey = GlobalKey<FormState>();
  String newTitle = "";

  @override
  Widget build(BuildContext context) {
    final PageProvider pageProvider = Provider.of<PageProvider>(context);

    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        width: size.width * 0.8,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 0.8,
            spreadRadius: 0.2,
          )
        ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      roomModel.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  FittedBox(
                    child: Text("Código: ${roomModel.code}"),
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(height: 40),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Creada: ${Utils.formatDate(roomModel.createdAt)}",
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black26,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                  if (!roomModel.createdAt
                      .isAtSameMomentAs(roomModel.updatedAt)) ...[
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Actualizada: ${Utils.formatDate(roomModel.updatedAt)}",
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black26,
                            fontWeight: FontWeight.w100),
                      ),
                    )
                  ]
                ],
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: TextButton(
                      onPressed: () {
                        dialogShow(context, size, pageProvider);
                      },
                      child: const Text("Cambiar nombre")),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: TextButton(
                      onPressed: () {
                        context.go("/${roomModel.id}/participants");
                      },
                      child: const Text("Ver participantes")),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: TextButton(
                      onPressed: () async {
                        await _roomConnection.deleteRoom(roomModel.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sala eliminada')),
                        );
                        pageProvider.page = 1;
                        context.go("/");
                      },
                      child: const Text("Eliminar sala")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void dialogShow(BuildContext context, Size size, PageProvider pageProvider) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Form(
              key: _formKey,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                height: 200,
                width: size.shortestSide * 0.8,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(children: [
                  const Text(
                    'Cambiar nombre de la sala',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: Container()),
                  TextFormField(
                    initialValue: roomModel.title,
                    onChanged: (value) => newTitle = value,
                    decoration: const InputDecoration(
                        hintText: 'Escriba su código de sala'),
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
                            if (_formKey.currentState!.validate()) {
                              Navigator.pop(context);
                              context.replace('/');
                              await _roomConnection.changeTitle(
                                  roomModel.id, newTitle);
                              pageProvider.page = 0;
                            }
                          },
                          child: const Text('Aceptar'))
                    ],
                  )
                ]),
              ),
            ),
          );
        });
  }
}
