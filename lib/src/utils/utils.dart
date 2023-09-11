import 'dart:convert';
import 'dart:developer' as dev;

import 'package:discover_meet/main.dart';
import 'package:discover_meet/src/connections/token_validation_connection.dart';
import 'package:discover_meet/src/models/json_convert_interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/page_provider.dart';

class Utils {
  static void check(BuildContext context) async {
    final PageProvider pageProvider = Provider.of<PageProvider>(context);

    pref.token = '';
    pageProvider.page = 1;
  }

  static String formatJson(String cadena) {
    if (cadena[0] != '[') {
      cadena = '[$cadena';
    }
    if (!cadena.endsWith(']')) {
      cadena = '$cadena]';
    }

    return cadena;
  }

  static bool isNumeric(String texto) {
    try {
      int.parse(texto);
      return true; // La conversión a int fue exitosa, es un número entero.
    } catch (e) {
      return false; // La conversión a int falló, no es un número entero.
    }
  }

  static String formatDate(DateTime fecha) {
    return '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';
  }
}
