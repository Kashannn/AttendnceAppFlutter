import 'package:flutter/material.dart';

class ViewAttendance extends StatefulWidget {
  ViewAttendance({Key? key}) : super(key: key);

  @override
  State<ViewAttendance> createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  // Example data for date and attendance status
  List<Map<String, dynamic>> attendanceData = [
    {'date': '2023-10-01', 'status': 'Present'},
    {'date': '2023-10-02', 'status': 'Absent'},
    {'date': '2023-10-03', 'status': 'Present'},
    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Date
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Date',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
            ),
          ),

          // Absent and Present
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Absent and Present',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
            ),
          ),

          // List view for date and attendance status
          Expanded(
            child: ListView.builder(

              itemCount: attendanceData.length,
              itemBuilder: (context, index) {
                // Get data for the current index
                Map<String, dynamic> data = attendanceData[index];

                return ListTile(
                  title: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data['date'].toString()),
                        Text(data['status'].toString()),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
