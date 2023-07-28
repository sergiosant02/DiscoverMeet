import 'dart:developer' as dev;
import 'dart:io';

import 'package:discover_meet/main.dart';
import 'package:discover_meet/src/connections/room_connection.dart';
import 'package:discover_meet/src/connections/user_connection.dart';
import 'package:discover_meet/src/image_picker/image_picker_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  File? image;
  UserConnection userConnection = UserConnection();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Container(
          child: Text('user'),
        ),
        ElevatedButton(
            onPressed: () async {
              image = await ImagePickerHelper.pickImage(ImageSource.gallery);

              if (image != null) {
                await userConnection.uploadPhoto(image!);
              } else {
                dev.log('foto nula');
              }
              setState(() {});
            },
            child: const Text('take a picture')),
        if (image != null) ...[
          SizedBox(height: 300, child: Image.file(image!))
        ],
        ElevatedButton(
            onPressed: () {
              pref.token = '';
              Navigator.pushNamed(context, '/home');
            },
            child: const Text('Sing out')),
      ],
    ));
  }
}
