import 'package:flutter/material.dart';

void main() => runApp(const MakeAttendance());

class MakeAttendance extends StatelessWidget {
  const MakeAttendance({Key? key}) : super(key: key);

  static const String _title = 'Attendance App';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: AttendanceScreen(),
    );
  }
}

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Background color
      appBar: AppBar(
        title: const Text(MakeAttendance._title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset('images/logo.png',
              width: 500,
              height: 300,
            ),
            const SizedBox(height: 20),
            const Text(
              'Tap to Mark Your Attendance',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Handle attendance marking logic here
              },
              child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.blue, // Checkmark color
                    size: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
