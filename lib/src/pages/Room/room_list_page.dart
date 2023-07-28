import 'package:discover_meet/src/connections/room_connection.dart';
import 'package:discover_meet/src/custom_widgets/room_widget.dart';
import 'package:discover_meet/src/models/room_model.dart';
import 'package:flutter/material.dart';

class RoomListPage extends StatefulWidget {
  const RoomListPage({Key? key}) : super(key: key);

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  final RoomConnection _roomConnection = RoomConnection();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _roomConnection.getJoinedRooms(),
        builder: (BuildContext context,
            AsyncSnapshot<List<RoomModel>> asyncSnapshot) {
          if (!asyncSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          List<RoomModel> data = asyncSnapshot.data!;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                return RoomWidget(
                  roomModel: data[i],
                  onTap: () {},
                );
              });
        });
  }
}
