import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:my_tasks_app/helpers/convert_helpers.dart';
import 'package:my_tasks_app/helpers/http_exception.dart';
import 'package:my_tasks_app/helpers/http_service.dart';
import 'package:my_tasks_app/models/list_model.dart';

class ListProvider with ChangeNotifier {
  List<ListModel> _items = [];

  HttpService httpService = HttpService.getInstance();

  List<ListModel> get items => _items;

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