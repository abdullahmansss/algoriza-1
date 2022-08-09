class TaskModel {
  final int id;
  final String title;
  final String date;
  final String startTime;
  final String endTime;
  final int reminder;
  final int color;
  final int completed;
  final int favorite;

  TaskModel({
    required this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.reminder,
    required this.color,
    required this.completed,
    required this.favorite,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'] as String,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      reminder: json['reminder'] as int,
      color: json['color'] as int,
      completed: json['completed'] as int,
      favorite: json['favorite'] as int,
      id: json['id'] as int,
    );
  }
}
