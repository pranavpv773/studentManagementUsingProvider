import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/screens/login_screen.dart';

void main() {
  runApp(
    const StudentManagement(),
  );
}

class StudentManagement extends StatelessWidget {
  const StudentManagement({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
