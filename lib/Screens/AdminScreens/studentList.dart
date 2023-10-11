import 'package:flutter/material.dart';
import 'attendanceDetail.dart';
import '../../DatabaseHelper/dbhelper.dart'; // Import your database helper
import '../../classes/user.dart'; // Import your User class

class AllStudent extends StatefulWidget {
  const AllStudent({Key? key}) : super(key: key);

  @override
  State<AllStudent> createState() => _AllStudentState();
}

class _AllStudentState extends State<AllStudent> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Students'),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        child: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text('Name: ${userList[index].name}'),
                subtitle: Text('Email: ${userList[index].email}'),
                trailing: IconButton(
                  onPressed: () {
                    print('Attendance Detail');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AttendanceDetail(studentId: userList[index].id)),
                    );
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
