import 'dart:async';
import 'dart:developer' as dev;

import 'package:discover_meet/main.dart';
import 'package:discover_meet/src/models/question_model.dart';
import 'package:discover_meet/src/models/question_type_model.dart';
import 'package:discover_meet/src/models/room_model.dart';
import 'package:discover_meet/src/utils/utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/constantes_globales.dart';

class QuestionConnection {
  String endPointServer = ConstantesGlobales.urlCurrentServidor;

  Future<List<QuestionModel>> getQuestions(String questionnaireId) async {
    List<QuestionModel> questionModelList = [];
    Uri uri = Uri.http(endPointServer, 'api/questionnaire/questions',
        {'questionnaireId': questionnaireId});
    final response = await http.get(
      uri,
      headers: {
        'Cookie': pref.token,
        'set-cookie': pref.token,
        'Authorization': pref.token,
      },
    );
    questionModelList = QuestionModel.fromJsonList(response.body);
    if (response.statusCode == 401) {
      validToken = false;
    } else {
      validToken = true;
    }
    return questionModelList;
  }
}
