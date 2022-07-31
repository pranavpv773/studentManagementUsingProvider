import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/colors.dart';
import 'package:flutter_application_1/domain/database/db_functions.dart';
import 'package:flutter_application_1/presentation/screens/edit_screen.dart';
import '../../domain/model/data_model.dart';

class ScreenStudentDetails extends StatelessWidget {
  final StudentModel studentmodel;

  const ScreenStudentDetails({required this.studentmodel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPink,
        ),
        body: SafeArea(
          child: Container(
            color: const Color.fromARGB(255, 19, 40, 85),
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'DETAILS',
                    style: TextStyle(
                      fontSize: 59,
                      fontWeight: FontWeight.bold,
                      color: kWhite,
                    ),
                  ),
                ),
                Divider(
                  color: kWhite,
                  thickness: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: 50,
                  child: StudentDbFunctions().imgstring.trim().isEmpty
                      ? CircleAvatar(
                          radius: 100,
                          backgroundImage: MemoryImage(
                            const Base64Decoder().convert(
                              studentmodel.imgstri,
                            ),
                          ),
                        )
                      : Container(
                          color: kWhite,
                        ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Center(
                  child: Text(
                    'Name : ${studentmodel.name}',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: kWhite,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    'Age: ${studentmodel.age}',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: kWhite,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    'Phone: ${studentmodel.phoneNumber}',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: kWhite,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    'Place: ${studentmodel.place}',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: kWhite,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 10,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        kPink,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => StudentEditScreen(
                            studentmodel: studentmodel,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Edit',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  color: kWhite,
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
