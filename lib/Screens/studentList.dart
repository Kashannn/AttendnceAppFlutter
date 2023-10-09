import 'package:flutter/material.dart';

import 'attendanceDetail.dart';

class AllStudent extends StatefulWidget {
  const AllStudent({Key? key}) : super(key: key);

  @override
  State<AllStudent> createState() => _AllStudentState();
}

class _AllStudentState extends State<AllStudent> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Students'),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        child: ListView.builder(
          itemCount: 2, // Adjust the itemCount based on your data
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text('Name: John Doe'), // Replace with user data
                subtitle: Text('Email: ${(index + 1)}'), // Replace with user data
                trailing: IconButton(
                  onPressed: () {
                    print('Attendance Detail');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AttendanceDetail()),
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
