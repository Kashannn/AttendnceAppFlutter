import 'package:flutter/material.dart';
import 'package:internship/classes/user.dart';
import '../../DatabaseHelper/dbhelper.dart';
import '../../classes/attendance.dart';

class ViewGrade extends StatefulWidget {
  const ViewGrade({super.key});

  @override
  State<ViewGrade> createState() => _ViewGradeState();
}

class _ViewGradeState extends State<ViewGrade> {
  List<User> userList = [];

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Future<void> getUsers() async {
    final dbHelper = DatabaseHelper();
    await dbHelper.openDatabase();
    await dbHelper.getAllUser().then((value) {
      setState(() {
        userList = value;
      });
    });
  }

  // Get Attendance by id
  Future<double> getAttendance(int? id) async {
    final dbHelper = DatabaseHelper();
    await dbHelper.openDatabase();
    List<Attendance> a = await dbHelper.getAttendanceDetailsForStudent(id);

    int present = 0;
    int absent = 0;
    for (var i = 0; i < a.length; i++) {
      String attendance = a[i].presence;
      if (attendance == 'Present') {
        present++;
      } else {
        absent++;
      }
    }

    double attendancePercentage = (present / (present + absent)) * 100;
    print(attendancePercentage);
    return attendancePercentage;
  }


  String calculateGrade(double attendancePercentage) {
    if (attendancePercentage >= 80) {
      return 'A';
    } else if (attendancePercentage >= 70) {
      return 'B';
    } else if (attendancePercentage >= 60) {
      return 'C';
    } else {
      return 'F';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grade'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: userList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      'Name: ${userList[index].name}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: FutureBuilder<double>(
                      future: getAttendance(userList[index].id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text('Loading...');
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          double attendancePercentage = snapshot.data!;
                          String grade = calculateGrade(attendancePercentage);

                          return Text(
                            'Grade: $grade',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
