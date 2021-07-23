import 'dart:convert';
import 'package:collection/collection.dart';

import 'package:flutter/cupertino.dart';
import 'package:my_tasks_app/helpers/convert_helpers.dart';
import 'package:my_tasks_app/helpers/http_service.dart';
import 'package:my_tasks_app/models/list_model.dart';
import 'package:my_tasks_app/models/todos.dart';

class ListProvider with ChangeNotifier {
  List<ListModel> _items = [];

  HttpService httpService = HttpService.getInstance();

  List<ListModel> get items => _items;

  List<Todos> getTodosByListId(int id) {
    final list = _items.firstWhereOrNull((element) => element.id == id);
    if(list != null) {
      return list.todos;
    }
    return [];
  }

  void toggleCheckTodo(Todos todo) {
    todo.toggleChecked();
    notifyListeners();
  }

  Future<void> fetchAndSetLists() async {
    try {
      final resData = await httpService.getLists();
      print(resData);
      if(resData != null && resData.isNotEmpty) {
        final List<dynamic> data = json.decode(resData);
        _items = data.map((e) => listFromJson(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}