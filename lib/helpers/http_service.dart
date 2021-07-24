import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_tasks_app/helpers/http_exception.dart';
import 'package:my_tasks_app/models/todos.dart';

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
      final url = '$baseUrl/list';
      final res = await http.get(Uri.parse(url));
      return res.body;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateTodo(int taskId, int listId, String title, bool checked) async {
    try {
      final url = '$baseUrl/list/$listId/todo/$taskId';
      final res = await http.patch(Uri.parse(url), body: {
        'text': title,
        'checked': checked.toString(),
      });
      if(res.statusCode >= 400) {
        throw HttpException(res.toString());
      }
    } on HttpException catch (e) {
      throw (e);
    } catch (e) {
      throw e;
    }
  }
}