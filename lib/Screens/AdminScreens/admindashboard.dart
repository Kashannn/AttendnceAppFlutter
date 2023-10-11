import 'package:flutter/material.dart';
import 'package:internship/classes/user.dart';

import 'studentList.dart';
import 'grade.dart';

class admindashboard extends StatefulWidget {

  admindashboard({Key? key}) : super(key: key);

  @override
  State<admindashboard> createState() => _admindashboardState();
}

class _admindashboardState extends State<admindashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.55,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.95,
              child: GridView.count(
                crossAxisCount: 3,
                children: [
                  GestureDetector(
                    onTap: () {
                      print('Grade Students');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewGrade()),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star_border_outlined,
                            size: 50,
                            color: Colors.blue,
                          ),
                          Text(
                            'Grade',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.send,
                            size: 50,
                            color: Colors.blue,
                          ),
                          Text(
                            'Request',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('View Attendance');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AllStudent()),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.school_outlined,
                            size: 50,
                            color: Colors.blue,
                          ),
                          Text(
                            'View',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  }

