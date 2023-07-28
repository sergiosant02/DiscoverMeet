import 'dart:developer' as dev;
import 'dart:io';

import 'package:discover_meet/src/utils/constantes_globales.dart';
import 'package:http/http.dart' as http;

class UserConnection {
  String endPointServer = ConstantesGlobales.urlServidorPruebas;

  Future<http.Response> login(String email, password) async {
    try {
      Uri uri = Uri.http(endPointServer, 'api/login');
      final http.Response response =
          await http.post(uri, body: {'email': email, 'password': password});
      dev.log(response.headers.toString());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future uploadPhoto(File file) async {
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
}
