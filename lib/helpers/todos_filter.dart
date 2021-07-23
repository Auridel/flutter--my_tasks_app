import 'package:my_tasks_app/models/todos.dart';

Map<String, List<Todos>> filterTodosByChecked(List<Todos> todos) {
  final incompleteTodos = todos.where((element) => !element.checked).toList();
  final completeTodos = todos.where((element) => element.checked).toList();
  return {
    'uncompletedTodos': incompleteTodos,
    'completedTodos': completeTodos,
  };
}