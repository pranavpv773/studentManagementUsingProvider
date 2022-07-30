import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:student_management/db/db_functions.dart';
import 'package:student_management/model/data_model.dart';
import 'package:student_management/screens/edit_screen.dart';

class ScreenStudentDetails extends StatelessWidget {
  final StudentModel studentmodel;

  const ScreenStudentDetails({required this.studentmodel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
        ),
        body: SafeArea(
          child: Container(
            color: const Color.fromARGB(255, 19, 40, 85),
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    'DETAILS',
                    style: TextStyle(
                      fontSize: 59,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: 50,
                  child: imgstring.trim().isEmpty
                      ? CircleAvatar(
                          radius: 100,
                          backgroundImage: MemoryImage(
                            const Base64Decoder().convert(studentmodel.imgstri),
                          ),
                        )
                      : Container(
                          color: Colors.white,
                        ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Center(
                  child: Text(
                    'Name : ${studentmodel.name}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    'Age: ${studentmodel.age}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    'Phone: ${studentmodel.phoneNumber}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    'Place: ${studentmodel.place}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.pink),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ScreenEdit(
                            studentmdoel: studentmodel,
                          ),
                        ),
                      );
                    },
                    child: const Text('Edit'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
