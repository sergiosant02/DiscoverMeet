import 'package:discover_meet/src/models/genre_enum.dart';
import 'package:discover_meet/src/models/user_model.dart';
import 'package:discover_meet/src/utils/utils.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  UserCard({super.key, required this.userModel});
  UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: size.shortestSide * 0.1,
                child: userModel.picture == null
                    ? Text(
                        userModel.firstName.substring(0, 2).toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.shortestSide * 0.08),
                      )
                    : FadeInImage(
                        placeholder:
                            const AssetImage("assets/icon/DiscoverMeet_icono_V3.png"),
                        image: NetworkImage(userModel.picture!.path)),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${userModel.firstName} ${userModel.lastName}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.shortestSide * 0.03),
                  ),
                  Text(
                    "Email: ${userModel.email}",
                    style: TextStyle(fontSize: size.shortestSide * 0.025),
                  ),
                  Text(
                    "Fecha de nacimiento ${Utils.formatDate(userModel.birthDate)}",
                    style: TextStyle(fontSize: size.shortestSide * 0.025),
                  ),
                  Text(
                    "Género: ${Genre.getTranslate(userModel.genre)}",
                    style: TextStyle(fontSize: size.shortestSide * 0.025),
                  ),
                  Text(
                    "Teléfono: ${userModel.phone}",
                    style: TextStyle(fontSize: size.shortestSide * 0.025),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
