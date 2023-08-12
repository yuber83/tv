import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class InternetChecker {
  Future<bool> hasInternet() async {
    try {
      if (kIsWeb) {
        final response = await get(Uri.parse('www.google.com'));
        return response.statusCode == 200;
      } else {
        final list = await InternetAddress.lookup('www.google.com');
        print(list);
        return (list.isNotEmpty && list.first.rawAddress.isNotEmpty);
      }
    } catch (e) {
      print(e.runtimeType);
      return false;
    }
  }
}
