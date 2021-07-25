import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_tasks_app/helpers/convert_helpers.dart';
import 'package:my_tasks_app/helpers/http_exception.dart';
import 'package:my_tasks_app/models/list_model.dart';
import 'package:my_tasks_app/models/todos.dart';

class HttpService {
  final baseUrl = 'http://mobile-dev.oblakogroup.ru/candidate/vitalypetrov/';

  static HttpService? _instance;

  static HttpService getInstance() {
    if (_instance == null) {
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
      throw e;
    }
  }

  Future<void> updateTodo(
      int taskId, int listId, String title, bool checked) async {
    try {
      final url = '$baseUrl/list/$listId/todo/$taskId';
      final res = await http.patch(Uri.parse(url), body: {
        'text': title,
        'checked': checked.toString(),
      });
      if (res.statusCode >= 400) {
        throw HttpException(res.toString());
      }
    } on HttpException catch (e) {
      throw (e);
    } catch (e) {
      throw e;
    }
  }

  Future<Todos> addTodo(int listId, String title, bool checked) async {
    try {
      final url = '$baseUrl/list/$listId/todo';
      final res = await http.post(Uri.parse(url), body: {
        'text': title,
        'checked': checked.toString(),
      });
      final Map<String, dynamic> resData = json.decode(res.body);
      return todosFromJson(resData);
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteList(int listId) async {
    try {
      final url = '$baseUrl/list/$listId';
      final res = await http.delete(Uri.parse(url));
      if (res.statusCode >= 400) {
        throw HttpException('Delete failed');
      }
    } on HttpException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future<ListModel> addList(String title) async {
    try {
      final url = '$baseUrl/list';
      final res = await http.post(Uri.parse(url), body: {
        'title': title,
      });
      final Map<String, dynamic> resData = json.decode(res.body);
      final ListModel list = listFromJson(resData);
      return list;
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteTask(int listId, int taskId) async {
    try {
      final url = '$baseUrl/list/$listId/todo/$taskId';
      final res = await http.delete(Uri.parse(url));
      if (res.statusCode >= 400) {
        throw HttpException('Delete task error');
      }
    } catch (e) {
      throw e;
    }
  }
}
