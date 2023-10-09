import 'package:flutter/material.dart';
import 'package:internship/classes/user.dart';
import '../DatabaseHelper/dbhelper.dart';
import '../classes/attendance.dart';

class gradeScreen extends StatefulWidget {

  gradeScreen({Key? key}) : super(key: key);

  @override
  _gradeScreenState createState() => _gradeScreenState();

}


class _gradeScreenState extends State<gradeScreen> {

  List<Attendance> attendence = [];


  Future<void> getAttendence() async {
    final dbHelper = DatabaseHelper();
    await dbHelper.openDatabase();
    await dbHelper.getAllAttendance().then((value) {
      //match the user id with the attendance user id
      for (var item in value) {

          setState(() {
            attendence.add(item);
          });

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
        title: Text('Grades'),
      ),
      body: Container(
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
    );
  }
}