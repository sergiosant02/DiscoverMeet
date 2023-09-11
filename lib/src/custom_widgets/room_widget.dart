import 'package:discover_meet/src/models/room_model.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  final RoomModel roomModel;
  final Function() onTap;
  const RoomWidget({
    Key? key,
    required this.roomModel,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
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
              width: size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roomModel.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text("Código: ${roomModel.code}")
                ],
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
