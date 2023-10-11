import 'package:flutter/material.dart';
import 'package:internship/classes/user.dart';

import '../../DatabaseHelper/dbhelper.dart';
import '../../classes/attendance.dart';

class ViewAttendance extends StatefulWidget {

  final User user;

  ViewAttendance({Key? key, required this.user}) : super(key: key);

  @override
  _ViewAttendanceState createState() => _ViewAttendanceState();

}


class _ViewAttendanceState extends State<ViewAttendance> {

  List<Attendance> attendence = [];


  Future<void> getAttendence() async {
    final dbHelper = DatabaseHelper();
    await dbHelper.openDatabase();
    await dbHelper.getAllAttendance().then((value) {
      //match the user id with the attendance user id
      for (var item in value) {
        if (item.studentId == widget.user.id) {
          setState(() {
            attendence.add(item);
          });
        }
      }
    });
  }

  @override
  void initState() {
    getAttendence();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DataTable(
                columns: [
                  DataColumn(
                    label: Text(
                      'No#',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Date',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Present/Absent',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: attendence
                    .map(
                      (e) =>
                      DataRow(cells: [
                        DataCell(
                          // Use the index parameter to display the sequential number:
                          Text((attendence.indexOf(e) + 1).toString()),
                        ),
                        DataCell(
                          Text(e.date.toString()),
                        ),
                        DataCell(
                          Text(e.presence.toString()),
                        ),
                      ]),
                )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}