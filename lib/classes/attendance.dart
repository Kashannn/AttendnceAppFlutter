class Attendance {
  final int? studentId;
  final String date;
  final String presence;

  Attendance({
    required this.studentId,
    required this.date,
    required this.presence,
  });

  //From Json
  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    studentId: json['student_id'],
    date: json['date'],
    presence: json['presence'],
  );
}