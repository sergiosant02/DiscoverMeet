import 'dart:developer' as dev;
import 'dart:io';

import 'package:discover_meet/main.dart';
import 'package:discover_meet/src/connections/user_connection.dart';
import 'package:discover_meet/src/custom_widgets/user_card.dart';
import 'package:discover_meet/src/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/page_provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  XFile? image;
  UserConnection userConnection = UserConnection();

  @override
  Widget build(BuildContext context) {
    final PageProvider _pageProvider = Provider.of<PageProvider>(context);
    final UserConnection userConnection = UserConnection();
    return FutureBuilder<UserModel>(
        future: userConnection.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Ha habido un error"));
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          UserModel user = snapshot.data!;
          return Center(
              child: Column(
            children: [
              UserCard(userModel: user),
              Container(
                child: Text('user'),
              ),
              ElevatedButton(
                  onPressed: () async {
                    ImagePicker imagePicker = ImagePicker();
                    image = await imagePicker.pickImage(
                        source: ImageSource.gallery);

                    if (image != null) {
                      await userConnection.uploadPhoto(image!);
                    } else {
                      dev.log('foto nula');
                    }
                    setState(() {});
                  },
                  child: const Text('take a picture')),
              if (image != null && !kIsWeb) ...[
                SizedBox(height: 300, child: Image.file(File(image!.path)))
              ],
              ElevatedButton(
                  onPressed: () {
                    context.goNamed('/updateUser',
                        queryParameters: user.toJson());
                  },
                  child: const Text('Actualizar')),
              ElevatedButton(
                  onPressed: () {
                    _pageProvider.page = 1;
                    pref.token = '';
                    context.replace('/');
                  },
                  child: const Text('Sing out')),
            ],
          ));
        });
  }
}
