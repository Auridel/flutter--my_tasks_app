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

  Future<void> editTask(Todos task, int newListId, String newTitle) async {
    try {
      if(newListId != task.listId) {
        final list = _items.firstWhere((element) => element.id == newListId);
        await httpService.deleteTask(task.listId, task.id);
        final newTask = await httpService.addTodo(newListId, newTitle, task.checked);
        list.todos.add(newTask);
      } else {
        await httpService.updateTodo(task.id, task.listId, newTitle, task.checked);
        task.changeText(newTitle);
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> fetchAndSetLists() async {
    try {
      final resData = await httpService.getLists();
      if(resData != null && resData.isNotEmpty) {
        final List<dynamic> data = json.decode(resData);
        _items = data.map((e) => listFromJson(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> addTodo(int listId, String title) async {
    try {
      final resData = await httpService.addTodo(listId, title, false);
      final list = _items.firstWhere((element) => element.id == listId);
      list.todos.add(resData);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteList(int listId) async {
    try {
      await httpService.deleteList(listId);
      _items.removeWhere((e) => e.id == listId);
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

  Future<void> deleteTask(int listId, int taskId) async {
    final list = _items.firstWhere((element) => element.id == listId);
    final idx = list.todos.indexWhere((element) => element.id == taskId);
    final task = list.todos[idx];
    try {
      list.todos.removeAt(idx);
      notifyListeners();
      await httpService.deleteTask(listId, taskId);
    } catch (e) {
      list.todos.insert(idx, task);
      notifyListeners();
      throw e;
    }
  }
}