import 'package:discover_meet/src/connections/room_connection.dart';
import 'package:discover_meet/src/models/room_model.dart';
import 'package:discover_meet/src/models/user_model.dart';
import 'package:flutter/material.dart';

import '../../custom_widgets/app_bar_discover.dart';
import '../../utils/interface_colors.dart';

class ListParticipantsRoom extends StatefulWidget {
  ListParticipantsRoom({super.key, required this.roomModelId});
  String roomModelId;

  @override
  State<ListParticipantsRoom> createState() => _ListParticipantsRoomState();
}

class _ListParticipantsRoomState extends State<ListParticipantsRoom> {
  RoomConnection _roomConnection = RoomConnection();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InterfaceColors.backgroundColor,
      appBar: AppBarDiscover.build(context, false),
      body: FutureBuilder(
          future: _roomConnection.getListParticipants(widget.roomModelId),
          builder: (context, snap) {
            if (snap.hasError) {
              return Center(
                  child: Text('Error al cargar la lista de participantes'));
            } else if (!snap.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              List<UserModel> participants = snap.data!;
              return ListView.builder(
                  itemCount: participants.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.all(5),
                      child: ListTile(
                        title: Text(participants[index].firstName),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
