import 'package:flutter/material.dart';
import 'package:my_tasks_app/helpers/todos_filter.dart';
import 'package:my_tasks_app/models/list_model.dart';
import 'package:my_tasks_app/widgets/completed_tasks_list.dart';
import 'package:my_tasks_app/widgets/task_item.dart';

class TaskList extends StatefulWidget {
  final ListModel list;

  TaskList(this.list);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todos = filterTodosByChecked(widget.list.todos);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.list.title,
            style: TextStyle(
              color: Theme.of(context).primaryTextTheme.headline4?.color,
              fontSize: Theme.of(context).primaryTextTheme.headline4?.fontSize,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 20,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, i) => TaskItem(todos['uncompletedTodos']![i]),
            itemCount: todos['uncompletedTodos']!.length,
            shrinkWrap: true,
          ),
          CompletedTasksList(todos['completedTodos'] ?? []),
        ],
      ),
    );
  }
}
