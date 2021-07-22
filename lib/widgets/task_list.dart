import 'package:flutter/material.dart';
import 'package:my_tasks_app/models/list_model.dart';

class TaskList extends StatelessWidget {
  final ListModel list;


  TaskList(this.list);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(list.title, style: TextStyle(
            color: Theme.of(context).primaryTextTheme.headline4?.color,
            fontSize: Theme.of(context).primaryTextTheme.headline4?.fontSize,
          ),
            textAlign: TextAlign.left,
          ),
          ...list.todos.map((e) => Container()).toList(),
        ],
      ),
    );
  }
}
