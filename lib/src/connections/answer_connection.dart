import 'dart:async';
import 'dart:developer' as dev;

import 'package:discover_meet/main.dart';
import 'package:discover_meet/src/models/answer_model.dart';
import 'package:discover_meet/src/models/question_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/constantes_globales.dart';

class AnswerConnection {
  String endPointServer = ConstantesGlobales.urlCurrentServidor;

  Future<List<QuestionModel>> postAnswer(AnswerModel answerModel) async {
    List<QuestionModel> questionModelList = [];
    Uri uri = Uri.http(endPointServer, 'api/answer/create',
        {"questionId": answerModel.question.id});
    final response = await http.post(uri, headers: {
      'Cookie': pref.token,
      'set-cookie': pref.token,
      'Authorization': pref.token,
    }, body: {
      "value": jsonEncode(answerModel.value)
    });

    if (response.statusCode == 401) {
      validToken = false;
    } else if (response.statusCode == 400) {
      dev.log("Body: ${response.body}");
      dev.log("Response: $response");
    }
    return questionModelList;
  }

  Future<List<QuestionModel>> postAnswerList(
      List<AnswerModel> answerModelLis) async {
    List<QuestionModel> questionModelList = [];
    for (AnswerModel ans in answerModelLis) {
      postAnswer(ans);
    }
    return questionModelList;
  }
}
