import 'dart:developer' as dev;

import 'package:discover_meet/main.dart';
import 'package:discover_meet/src/models/questionnaire_model.dart';
import 'package:discover_meet/src/models/room_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/constantes_globales.dart';

class RoomConnection {
  String endPointServer = ConstantesGlobales.urlServidorPruebas;

  Future<List<RoomModel>> getJoinedRooms() async {
    try {
      Uri uri = Uri.http(endPointServer, 'api/room/joinedRooms');
      final response = await http.get(
        uri,
        headers: {
          'Cookie': pref.token,
          'set-cookie': pref.token,
          'Authorization': pref.token,
        },
      );
      String cadena = response.body;
      if (cadena[0] != '[') {
        cadena = '[$cadena';
      }
      if (!cadena.endsWith(']')) {
        cadena = '$cadena]';
      }
      dynamic jsonResponse = jsonDecode(cadena);

      List<RoomModel> roomModelList = [];

      if (jsonResponse is List) {
        for (var val in jsonResponse) {
          try {
            String json = jsonEncode(val);
            RoomModel room = RoomModel.fromRawJson(json);
            roomModelList.add(room);
          } catch (e) {
            dev.log("Error:");
            dev.log(e.toString());
          }
        }

        // Aquí puedes usar la lista roomModelList como desees
      } else {
        RoomModel room = RoomModel.fromJson(jsonResponse);
        roomModelList.add(room);
      }

      return roomModelList;
    } catch (e) {
      dev.log(e.toString());
      rethrow;
    }
  }

  Future<List<QuestionnaireModel>?> getQuestionnairesList(String roomId) async {
    try {
      Uri uri = Uri.http(endPointServer, 'api/room/questionnaires');
      final response = await http.get(
        uri,
        headers: {
          'Cookie': pref.token,
          'set-cookie': pref.token,
          'Authorization': pref.token,
        },
      );
      return null;
    } catch (e) {
      dev.log(e.toString());
    }
  }
}
