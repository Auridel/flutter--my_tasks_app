import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  final baseUrl = 'http://mobile-dev.oblakogroup.ru/candidate/vitalypetrov/';

  static HttpService? _instance;

  static HttpService getInstance() {
    if(_instance == null) {
      _instance = HttpService();
    }
    return _instance!;
  }

  Future<String?> getLists() async {
    try {
      final url = '$baseUrl/lists';
      final res = await http.get(Uri.parse(url));
      return res.body;
    } catch (e) {
      print(e.toString());
    }
  }
}