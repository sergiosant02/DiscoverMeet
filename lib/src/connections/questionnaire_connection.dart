import 'dart:developer' as dev;

import 'package:discover_meet/main.dart';
import 'package:discover_meet/src/models/QuestionType.dart';
import 'package:discover_meet/src/models/question_model.dart';
import 'package:discover_meet/src/models/questionnaire_model.dart';
import 'package:discover_meet/src/models/room_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/constantes_globales.dart';

class QuestionnaireConnection {
  String endPointServer = ConstantesGlobales.urlCurrentServidor;

  Future<List<QuestionnaireModel>> getQuestionnairesOfRoom(
      String roomId) async {
    try {
      Uri uri = Uri.http(
          endPointServer, 'api/room/questionnaires', {'roomId': roomId});
      dev.log(uri.toString());
      final response = await http.get(
        uri,
        headers: {
          'Cookie': pref.token,
          'set-cookie': pref.token,
          'Authorization': pref.token,
        },
      );

      String cadena = response.body;
      dev.log(cadena);
      if (cadena[0] != '[') {
        cadena = '[$cadena';
      }
      if (!cadena.endsWith(']')) {
        cadena = '$cadena]';
      }
      dynamic jsonResponse = jsonDecode(cadena);

      List<QuestionnaireModel> questionnireModelList = [];

      if (jsonResponse is List) {
        for (var val in jsonResponse) {
          try {
            String json = jsonEncode(val);
            QuestionnaireModel questionnaire =
                QuestionnaireModel.fromRawJson(json);
            questionnireModelList.add(questionnaire);
          } catch (e) {
            dev.log("Error:");
            dev.log(e.toString());
          }
        }

        // Aquí puedes usar la lista roomModelList como desees
      } else {
        QuestionnaireModel questionnaire =
            QuestionnaireModel.fromJson(jsonResponse);
        questionnireModelList.add(questionnaire);
      }

      return questionnireModelList;
    } catch (e) {
      dev.log(e.toString());
      rethrow;
    }
  }
}
