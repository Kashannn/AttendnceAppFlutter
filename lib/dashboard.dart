import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internship/DatabaseHelper/dbhelper.dart';
import 'dart:io';

import 'package:internship/ViewAttendence.dart';

import 'classes/attendance.dart';
import 'classes/user.dart';

class UserDashboard extends StatefulWidget {
  final User user;

  UserDashboard({Key? key, required this.user}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {

  @override
  void initState() {
    _loadProfileImage();
    super.initState();
  }

  String _profileImagePath = '';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String imagePath = pickedFile.path;
      await DatabaseHelper().updateUserImage(widget.user.id!, imagePath);
      _loadProfileImage();
    }
  }

  Future<void> _loadProfileImage() async {
    String? imagePath = await DatabaseHelper().getUserImage(widget.user.id!);
    if (imagePath != null && imagePath.isNotEmpty) {
      setState(() {
        _profileImagePath = imagePath;
      });
    }
  }

  //Already marked attendance popup
  Future<void> _alreadyMarkedAttendance(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return  AlertDialog(
          title: Text('Already Marked Attendance'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You have already marked your attendance for today'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //Alert Dialog Box for Absent Description
  Future<void> _absentDescription(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Absent Description'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text('Please enter the reason for your absence'),
                TextFormField(
                  minLines: 3,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Reason',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () async {
                String date = DateTime.now().toString().substring(0, 10);
                Attendance atteendence = Attendance(date: date, presence: 'Absent', studentId: widget.user.id);
                final dbHelper = DatabaseHelper();
                await dbHelper.openDatabase();
                await dbHelper.insertAttendance(atteendence);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //Alert Dialog Box for Present Confirmation
  Future<void> _presentConfirmation(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to mark your attendance?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                String date = DateTime.now().toString().substring(0, 10);
                print (date);

                Attendance atteendence = Attendance(date: date, presence: 'Present', studentId: widget.user.id);
                final dbHelper = DatabaseHelper();
                await dbHelper.openDatabase();
                await dbHelper.insertAttendance(atteendence);

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _profileImagePath.isNotEmpty
                                ? FileImage(File(_profileImagePath))
                                : null,
                          ),
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: OutlinedButton(
                          onPressed: () {
                            print('Logout');
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            side: BorderSide(color: Colors.white), // Set the border color
                          ),
                          child: Text(
                            'Logout',
                            style: TextStyle(color: Colors.white), // Set the text color
                          ),
                        ),
                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Email:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10), // Adjusted space between label and value
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.user.name}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${widget.user.email}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )

            ,
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width * 0.95,
              child: GridView.count(
                crossAxisCount: 3,
                children: [
                  GestureDetector(
                    onTap: () async {
                      print('Mark Present');

                      bool check = false;
                      //Get all Attendance from dbhelper
                      final dbHelper = DatabaseHelper();
                      await dbHelper.openDatabase();
                      await dbHelper.getAllAttendance().then((value) {

                        //match the user id with the attendance user id
                        for (var item in value) {
                          if (item.studentId == widget.user.id && item.date == DateTime.now().toString().substring(0, 10)) {
                            print('Attendance already marked');
                            check = true;
                            _alreadyMarkedAttendance(context);

                           // _alreadyMarked(context);
                            return null;

                          }

                        }
                      });
                      //if attendance not marked then mark attendance
                      if (check == false) {
                        _presentConfirmation(context);
                      }

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
                            Icons.how_to_reg,
                            size: 50,
                            color: Colors.blue,
                          ),
                          Text(
                            'Mark Present',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      bool check = false;
      final dbHelper = DatabaseHelper();
      await dbHelper.openDatabase();
      await dbHelper.getAllAttendance().then((value) {

        //match the user id with the attendance user id
        for (var item in value) {
          if (item.studentId == widget.user.id && item.date == DateTime.now().toString().substring(0, 10)) {
            print('Attendance already marked');
            check = true;
            _alreadyMarkedAttendance(context);

            // _alreadyMarked(context);
            return null;

          }}});
      if(check==false){
        _absentDescription(context);
      }
                      print('Mark Leave');
                      //
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
                            Icons.person_remove,
                            size: 50,
                            color: Colors.blue,
                          ),
                          Text(
                            'Mark Leave',
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
                      //Navigate to View Attendance Page (ViewAttendance.dart)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewAttendance(
                              user: widget.user,
                            )),
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
                            Icons.list,
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