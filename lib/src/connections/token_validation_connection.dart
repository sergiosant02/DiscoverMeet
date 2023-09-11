import '../../main.dart';
import '../utils/constantes_globales.dart';
import 'package:http/http.dart' as http;

class TokenValidationConnection {
  static Future<bool> validateToken(String token) async {
    String endPointServer = ConstantesGlobales.urlCurrentServidor;
    bool res = true;
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
      if (response.statusCode == 401) res = false;
    } catch (e) {
      rethrow;
    }
    return res;
  }
}
