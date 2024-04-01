// ignore_for_file: non_constant_identifier_names

class TaskData{
  // int userID;
  String ID;
  String title;
  bool is_completed;
  String description;
  // String timeCompleted;
  TaskData({
    required this.ID,
    // required this.userID,
    required this.title,
    required this.is_completed, 
    required this.description,
    // required this.timeCompleted
  });
}