import 'package:discover_meet/main.dart';
import 'package:discover_meet/src/custom_widgets/my_room_widget.dart';
import 'package:discover_meet/src/models/room_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../connections/room_connection.dart';
import '../../providers/page_provider.dart';

class MyRoomListPage extends StatefulWidget {
  const MyRoomListPage({super.key});

  @override
  State<MyRoomListPage> createState() => _MyRoomListPageState();
}

class _MyRoomListPageState extends State<MyRoomListPage> {
  final RoomConnection _roomConnection = RoomConnection();
  @override
  Widget build(BuildContext context) {
    final PageProvider pageProvider = Provider.of<PageProvider>(context);
    if (validToken) {
      return FutureBuilder(
          future: _roomConnection.getMyRooms(),
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
                  return MyRoomWidget(
                    roomModel: data[i],
                    onTap: () {
                      context.go("/${data[i].id}/questionnaire/mine");
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
                  pageProvider.page = 1;
                },
                child: const Text('Iniciar sesión'))
          ],
        ),
      );
    }
  }
}
