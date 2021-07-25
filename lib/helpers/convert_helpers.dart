import 'package:my_tasks_app/models/list_model.dart';
import 'package:my_tasks_app/models/todos.dart';

ListModel listFromJson(Map<String, dynamic> json) {
  final int id = json['id'];
  final String title = json['title'];
  final int candidateId = json['candidate_id'];
  final String createdAt = json['created_at'];
  final String updatedAt = json['updated_at'];
  List<Todos> todos = [];
  if (json['todos'] != null) {
    todos = json['todos'].map<Todos>((v) {
      return todosFromJson(v);
    }).toList();
  }
  return ListModel(
      id: id,
      title: title,
      candidateId: candidateId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      todos: todos);
}

Todos todosFromJson(Map<String, dynamic> json) {
  final int id = json['id'];
  final String text = json['text'];
  final int listId = json['list_id'];
  final bool checked = json['checked'];
  final String createdAt = json['created_at'];
  final String updatedAt = json['updated_at'];

  return Todos(
      id: id,
      text: text,
      listId: listId,
      checked: checked,
      createdAt: createdAt,
      updatedAt: updatedAt);
}
