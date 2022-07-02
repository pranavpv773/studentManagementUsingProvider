import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:student_management/db/db_functions.dart';
import 'package:student_management/model/data_model.dart';
import 'package:student_management/screens/add_screen.dart';
import 'package:student_management/screens/search_screen.dart';
import 'package:student_management/screens/student_details_screen.dart';

ValueNotifier<List<StudentModel>> temp = ValueNotifier([]);

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getallStudents();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Teacher's Record"),
          backgroundColor: Colors.pink,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => ScreenSearch(),
                  ),
                );
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: Container(
          color: const Color.fromARGB(255, 19, 40, 85),
          child: ValueListenableBuilder(
            valueListenable: studentlistNotifier,
            builder: (BuildContext ctx, List<StudentModel> studentList,
                Widget? child) {
              return ListView.separated(
                itemBuilder: (ctx, index) {
                  final data = studentList[index];
                  return ListTile(
                    title: Text(
                      data.name,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      data.age,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: CircleAvatar(
                      radius: 40,
                      child: imgstring.trim().isEmpty
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: MemoryImage(
                                const Base64Decoder().convert(
                                  studentList[index].imgstri,
                                ),
                              ),
                            )
                          : Container(
                              color: Colors.white,
                            ),
                    ),
                    trailing: IconButton(
                      color: Colors.pink,
                      onPressed: () {
                        if (data.id != null) {
                          deleteStudent(data.id!);
                        }
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ScreenStudentDetails(
                            studentmodel: studentList[index],
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider(
                    color: Colors.white,
                    indent: 15,
                    endIndent: 10,
                    thickness: 3,
                  );
                },
                itemCount: studentList.length,
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Colors.pink,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) {
                  return const ScreenAdd();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
