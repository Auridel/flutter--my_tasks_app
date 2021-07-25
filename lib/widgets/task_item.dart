import 'package:flutter/material.dart';
import 'package:my_tasks_app/models/todos.dart';
import 'package:my_tasks_app/providers/list_provider.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatelessWidget {
  final Todos task;
  final Function showError;

  TaskItem(this.task, this.showError);

  @override
  Widget build(BuildContext context) {
    final isChecked = task.checked;
    final primaryTheme = Theme.of(context).primaryTextTheme;
    return GestureDetector(
      onTap: () {
        Provider.of<ListProvider>(context, listen: false)
            .toggleCheckTodo(task)
            .then((_) => null)
            .catchError((_) {
          showError();
        });
      },
      child: ListTile(
        leading: isChecked
            ? Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
              )
            : Icon(Icons.radio_button_off),
        title: Text(
          task.text.trim(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isChecked
                ? primaryTheme.overline?.color
                : primaryTheme.headline3?.color,
            decoration: isChecked
                ? primaryTheme.overline?.decoration
                : TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
