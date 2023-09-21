import 'dart:developer' as dev;

import 'package:discover_meet/src/models/user_model.dart';
import 'package:discover_meet/src/utils/constantes_globales.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../main.dart';

class UserConnection {
  String endPointServer = ConstantesGlobales.urlCurrentServidor;

  Future<http.Response> login(String email, password) async {
    try {
      Uri uri = Uri.http(endPointServer, 'api/login');
      final http.Response response =
          await http.post(uri, body: {'email': email, 'password': password});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> signup(UserModel user) async {
    try {
      Uri uri = Uri.http(endPointServer, 'api/register');
      final http.Response response = await http.post(uri, body: user.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> updateUser(UserModel user) async {
    try {
      dev.log("Actualizando usuario: ${user.createdAt!.toIso8601String()}");
      Uri uri = Uri.http(endPointServer, 'api/update');
      Map<String, dynamic> body = user.toJson();
      final http.Response response = await http.put(
        uri,
        body: body,
        headers: {
          'Cookie': pref.token,
          'set-cookie': pref.token,
          'Authorization': pref.token,
        },
      );
      if (response.statusCode == 400) {
        dev.log(response.body);
      }
      return response;
    } catch (e) {
      dev.log(e.toString());
      rethrow;
    }
  }

  Future uploadPhoto(XFile file) async {
    try {
      Uri uri = Uri.http(endPointServer, 'api/uploadPicture');
      http.MultipartRequest request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      http.StreamedResponse response = await request.send();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getCurrentUser() async {
    try {
      Uri uri = Uri.http(endPointServer, 'api/user');
      final http.Response response = await http.get(
        uri,
        headers: {
          'Cookie': pref.token,
          'set-cookie': pref.token,
          'Authorization': pref.token,
        },
      );
      List<UserModel> users = UserModel.fromJsonList(response.body);
      return users[0];
    } catch (e) {
      rethrow;
    }
  }
}
