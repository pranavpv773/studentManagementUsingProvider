import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/colors.dart';
import 'package:flutter_application_1/domain/database/db_functions.dart';
import 'package:flutter_application_1/presentation/screens/add_screen.dart';
import 'package:flutter_application_1/presentation/screens/student_details_screen.dart';
import 'package:provider/provider.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<StudentDbFunctions>(context, listen: false)
            .getallStudents();
      },
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Teacher's Record"),
          backgroundColor: kPink,
          actions: [
            IconButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (ctx) => ScreenSearch(),
                //   ),
                // );
              },
              icon: const Icon(
                Icons.search,
              ),
            )
          ],
        ),
        body: Container(
          color: const Color.fromARGB(255, 19, 40, 85),
          child: Consumer<StudentDbFunctions>(
            builder: (context, value, child) {
              return ListView.separated(
                itemBuilder: (ctx, index) {
                  final data = value.studentlistNotifier[index];
                  return ListTile(
                    title: Text(
                      data.name,
                      style: TextStyle(
                        color: kWhite,
                      ),
                    ),
                    subtitle: Text(
                      data.age,
                      style: TextStyle(
                        color: kWhite,
                      ),
                    ),
                    leading: CircleAvatar(
                      radius: 40,
                      child: data.imgstri.isEmpty
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: MemoryImage(
                                const Base64Decoder().convert(
                                  data.imgstri,
                                ),
                              ),
                            )
                          : Container(
                              color: kWhite,
                            ),
                    ),
                    trailing: IconButton(
                      color: kPink,
                      onPressed: () {
                        if (data.id != null) {
                          Provider.of<StudentDbFunctions>(context)
                              .deleteStudent(data.id!);
                        }
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ScreenStudentDetails(
                            studentmodel: value.studentlistNotifier[index],
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (ctx, index) {
                  return Divider(
                    color: kWhite,
                    indent: 15,
                    endIndent: 10,
                    thickness: 3,
                  );
                },
                itemCount: value.studentlistNotifier.length,
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: kPink,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) {
                  return StudentAddScreen();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
