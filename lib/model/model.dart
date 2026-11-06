class MyTask {
  String title = "";
  String? description;
  bool isDone = false;
  DateTime? taskDate;

  MyTask({
    required this.title,
    this.description,
    this.isDone = false,
    DateTime? datetime,
  }) : taskDate = datetime ?? DateTime.now();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['isDone'] = isDone;
    data['DateTime'] = taskDate.toString();

    return data;
  }

  MyTask.fromMap(Map<String, dynamic> data) {
    title = data['title'];
    description = data['description'];
    isDone = data['isDone'];
    taskDate = data['taskDate'] != null
        ? DateTime.parse(data['taskDate'])
        : DateTime.now();
  }
}
