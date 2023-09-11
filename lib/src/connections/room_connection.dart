import 'dart:async';
import 'dart:developer' as dev;

import 'package:discover_meet/main.dart';
import 'package:discover_meet/src/exceptions/jwt_expired_exception.dart';
import 'package:discover_meet/src/models/questionnaire_model.dart';
import 'package:discover_meet/src/models/room_model.dart';
import 'package:discover_meet/src/models/user_model.dart';
import 'package:discover_meet/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/page_provider.dart';
import '../utils/constantes_globales.dart';

class RoomConnection {
  String endPointServer = ConstantesGlobales.urlCurrentServidor;

  Future<List<RoomModel>> getJoinedRooms() async {
    Uri uri = Uri.http(endPointServer, 'api/room/joinedRooms');
    final response = await http.get(
      uri,
      headers: {
        'Cookie': pref.token,
        'set-cookie': pref.token,
        'Authorization': pref.token,
      },
    );

    List<RoomModel> roomModelList = RoomModel.fromJsonList(response.body);
    if (response.statusCode == 401) {
      validToken = false;
    } else {
      validToken = true;
    }
    return roomModelList;
  }

  Future<bool> joinToRoom(String code) async {
    Uri uri =
        Uri.http(endPointServer, 'api/room/addParticipant', {'roomCode': code});
    bool res = true;
    final response = await http.post(
      uri,
      headers: {
        'Cookie': pref.token,
        'set-cookie': pref.token,
        'Authorization': pref.token,
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      res = true;
    } else {
      res = false;
    }
    return res;
  }

  Future<List<RoomModel>> getMyRooms() async {
    Uri uri = Uri.http(endPointServer, 'api/room/myRooms');
    final response = await http.get(
      uri,
      headers: {
        'Cookie': pref.token,
        'set-cookie': pref.token,
        'Authorization': pref.token,
      },
    );

    List<RoomModel> roomModelList = RoomModel.fromJsonList(response.body);
    if (response.statusCode == 401) {
      validToken = false;
    } else {
      validToken = true;
    }
    return roomModelList;
  }

  Future<bool> changeTitle(String roomId, String title) async {
    Uri uri =
        Uri.http(endPointServer, 'api/room/changeTitle', {'roomId': roomId});
    bool res = true;
    final response = await http.put(uri, headers: {
      'Cookie': pref.token,
      'set-cookie': pref.token,
      'Authorization': pref.token,
    }, body: {
      "title": title
    });
    if (response.statusCode >= 200 && response.statusCode < 300) {
      res = true;
    } else {
      dev.log(response.body);
      res = false;
    }
    return res;
  }

  Future<List<UserModel>> getListParticipants(String roomId) async {
    Uri uri =
        Uri.http(endPointServer, 'api/room/participants', {'roomId': roomId});
    List<UserModel> userModelList = [];
    final response = await http.get(
      uri,
      headers: {
        'Cookie': pref.token,
        'set-cookie': pref.token,
        'Authorization': pref.token,
      },
    );
    userModelList = UserModel.fromJsonList(response.body);
    dev.log(response.body);
    return userModelList;
  }
}
