class Request{

  int? id;
  final int studentId;
  final String date;
  final String reason;

  Request({
    this.id,
    required this.studentId,
    required this.date,
    required this.reason,
  });

  //From Json
  factory Request.fromJson(Map<String, dynamic> json) => Request(
    id: json['id'],
    studentId: json['student_id'],
    date: json['date'],
    reason: json['reason'],
  );

}