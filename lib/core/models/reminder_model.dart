class ReminderModel {
  final String reminder;
  final int minutes;

  ReminderModel({
    required this.reminder,
    required this.minutes,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      reminder: json['reminder'] as String,
      minutes: json['minutes'] as int,
    );
  }
}