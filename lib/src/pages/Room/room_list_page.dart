import 'dart:developer';

import 'package:discover_meet/main.dart';
import 'package:discover_meet/src/connections/room_connection.dart';
import 'package:discover_meet/src/connections/token_validation_connection.dart';
import 'package:discover_meet/src/custom_widgets/room_widget.dart';
import 'package:discover_meet/src/exceptions/jwt_expired_exception.dart';
import 'package:discover_meet/src/models/room_model.dart';
import 'package:discover_meet/src/pages/Questionnaire/questionnaire_list_page.dart';
import 'package:discover_meet/src/providers/page_provider.dart';
import 'package:discover_meet/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RoomListPage extends StatefulWidget {
  const RoomListPage({Key? key}) : super(key: key);

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  final RoomConnection _roomConnection = RoomConnection();
  @override
  Widget build(BuildContext context) {
    final PageProvider _pageProvider = Provider.of<PageProvider>(context);
    if (validToken) {
      return FutureBuilder(
          future: _roomConnection.getJoinedRooms(),
          builder: (BuildContext context,
              AsyncSnapshot<List<RoomModel>> asyncSnapshot) {
            if (asyncSnapshot.hasError) {
              return const Center(child: Text('Ha ocurrido un error'));
            } else if (!asyncSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            List<RoomModel> data = asyncSnapshot.data!;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return RoomWidget(
                    roomModel: data[i],
                    onTap: () {
                      context.go("/${data[i].id}/questionnaire");
                    },
                  );
                });
          });
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'Vuelva a iniciar sesión.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  pref.token = '';
                  context.replace("/");
                  _pageProvider.page = 1;
                },
                child: const Text('Iniciar sesión'))
          ],
        ),
      );
    }
  }
}
