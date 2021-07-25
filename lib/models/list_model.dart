import 'package:my_tasks_app/models/todos.dart';

class ListModel {
  int id;
  String title;
  int candidateId;
  String createdAt;
  String updatedAt;
  List<Todos> todos;

  ListModel(
      {required this.id,
      required this.title,
      required this.candidateId,
      required this.createdAt,
      required this.updatedAt,
      required this.todos});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['candidate_id'] = this.candidateId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.todos != null) {
      data['todos'] = this.todos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
