class Todos {
  final int id;
  final String text;
  final int listId;
  bool checked;
  final String createdAt;
  final String updatedAt;

  Todos(
      {required this.id,
        required this.text,
        required this.listId,
        required this.checked,
        required this.createdAt,
        required this.updatedAt});

  void toggleChecked() {
    checked = !checked;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['list_id'] = this.listId;
    data['checked'] = this.checked;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}