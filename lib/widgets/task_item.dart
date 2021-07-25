import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_tasks_app/models/todos.dart';
import 'package:my_tasks_app/providers/list_provider.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatelessWidget {
  final Todos task;
  final Function() showError;
  final Function(int taskId) removeTask;

  TaskItem({required this.task, required this.showError, required this.removeTask, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final isChecked = task.checked;
    final theme = Theme.of(context);
    return Slidable(
      actionPane: SlidableStrechActionPane(),
      actionExtentRatio: 0.18,
      actions: [
        Container(
          decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1, color: Colors.black38)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconSlideAction(
              color: theme.backgroundColor,
              iconWidget: Icon(
                Icons.edit,
                color: Colors.black54,
              ),
            ),
          ),
        )
      ],
      secondaryActions: [
        Container(
          decoration: BoxDecoration(
            border: Border(left: BorderSide(width: 1, color: Colors.black38)),
          ),
          child: IconSlideAction(
            color: theme.backgroundColor,
            iconWidget: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                CupertinoIcons.trash,
                color: theme.errorColor,
              ),
            ),
            onTap: () {
              removeTask(task.id);
            },
          ),
        )
      ],
      child: GestureDetector(
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
                  ? theme.primaryTextTheme.overline?.color
                  : theme.primaryTextTheme.headline3?.color,
              decoration: isChecked
                  ? theme.primaryTextTheme.overline?.decoration
                  : TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
