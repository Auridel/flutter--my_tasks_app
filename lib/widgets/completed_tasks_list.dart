import 'package:flutter/material.dart';
import 'package:my_tasks_app/models/todos.dart';
import 'package:my_tasks_app/widgets/task_item.dart';

class CompletedTasksList extends StatefulWidget {
  final List<Todos> todos;
  final Function() showError;
  final Function(int taskId) _removeTask;

  CompletedTasksList(this.todos, this.showError, this._removeTask);

  @override
  _CompletedTasksListState createState() => _CompletedTasksListState();
}

class _CompletedTasksListState extends State<CompletedTasksList> {
  final double listItemHeight = 56;
  var isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final primaryText = Theme
        .of(context)
        .primaryTextTheme;
    return Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: ListTile(
            leading: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons
                      .keyboard_arrow_down),
              title: Text('Завершенные',
                  style: TextStyle(
                    color: primaryText.headline3?.color,
                  )),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 150),
            height: isExpanded ? widget.todos.length * listItemHeight : 0,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (ctx, i) => TaskItem(task: widget.todos[i], showError:  widget.showError, removeTask: widget._removeTask,),
              itemCount: widget.todos.length,
            ),
          )
        ],
    );
  }
}
