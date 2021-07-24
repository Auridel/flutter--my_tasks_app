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

  Future<void> toggleCheckTodo(Todos todo) async {
    try {
      todo.toggleChecked();
      notifyListeners();
      await httpService.updateTodo(todo.id, todo.listId, todo.text, !todo.checked);
    } catch (e) {
      todo.toggleChecked();
      notifyListeners();
      throw e;
    }
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

  Future<void> addTodo(int listId, String title) async {
    try {
      final resData = await httpService.addTodo(listId, title);
      final list = _items.firstWhere((element) => element.id == listId);
      list.todos.add(resData);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteList(int listId) async {
    final idx = _items.indexWhere((element) => element.id == listId);
    final list = _items[idx];
    try {
      await httpService.deleteList(listId);
      _items.removeAt(idx);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addList(String title) async {
    try {
      final ListModel list = await httpService.addList(title);
      _items.add(list);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}