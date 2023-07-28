// ignore_for_file: file_names

import 'package:flutter/foundation.dart';

class PageProvider with ChangeNotifier {
  int _page = 1;

  int get page => _page;

  set page(int newPage) {
    _page = newPage; //actualizamos el valor
    notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
  }
}
