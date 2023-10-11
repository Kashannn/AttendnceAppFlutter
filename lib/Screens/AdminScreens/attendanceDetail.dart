import 'package:flutter/material.dart';
import '../../DatabaseHelper/dbhelper.dart'; // Import your database helper
import '../../classes/attendance.dart'; // Import your Attendance class

class AttendanceDetail extends StatefulWidget {
  final int? studentId; // Add a field to store the student ID

  const AttendanceDetail({Key? key, required this.studentId}) : super(key: key);

  @override
  State<AttendanceDetail> createState() => _AttendanceDetailState();
}

class _AttendanceDetailState extends State<AttendanceDetail> {
  List<Attendance> attendanceList = []; // Assuming Attendance is your data model

  @override
  void initState() {
    super.initState();
    getAttendanceDetails();
  }

  Future<void> getAttendanceDetails() async {
    final dbHelper = DatabaseHelper();
    await dbHelper.openDatabase();
    print('Student ID: ${widget.studentId}');
    print('Attendance Details: ${await dbHelper.getAttendanceDetailsForStudent(widget.studentId!)}');
    List<Attendance> a = await dbHelper.getAttendanceDetailsForStudent(widget.studentId!);
    setState(() {
      attendanceList = a;
    });
    print(attendanceList.length);
  }

  Future<void> deleteAttendance(int id) async {
    final dbHelper = DatabaseHelper();
    await dbHelper.openDatabase();
    // Delete the user-marked attendance
    await dbHelper.deleteAttendance(id);

    // You can add additional logic here to handle admin's action
    // ...

    // Refresh the attendance list
    getAttendanceDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Detail'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        child: ListView.builder(
          itemCount: attendanceList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text('Date: ${attendanceList[index].date.toString()}'),
                subtitle: Text('Attendance: ${attendanceList[index].presence.toString()}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle edit action
                        // You can pass attendanceList[index] to the editing screen if needed
                        // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => EditAttendanceScreen(attendance: attendanceList[index])));
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle delete action
                        // You can show a confirmation dialog and delete the attendance record
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm Delete'),
                              content: Text('Are you sure you want to delete this attendance record?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    print(attendanceList[1].presence);
                                    // Delete user-marked attendance and handle admin's action
                                    deleteAttendance(attendanceList[index].id!);
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
