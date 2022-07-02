// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:student_management/db/db_functions.dart';
import 'package:student_management/model/data_model.dart';
import 'package:student_management/screens/student_details_screen.dart';

ValueNotifier<List<StudentModel>> temp = ValueNotifier([]);

class ScreenSearch extends StatelessWidget {
  ScreenSearch({Key? key}) : super(key: key);

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.pink,
          title: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              onTap: () {},
              onChanged: (String? value) {
                if (value == null || value.isEmpty) {
                  temp.value.addAll(studentlistNotifier.value);
                  temp.notifyListeners();
                } else {
                  temp.value.clear();
                  for (StudentModel i in studentlistNotifier.value) {
                    if (i.name.toLowerCase().contains(
                          value.toLowerCase(),
                        )) {
                      temp.value.add(i);
                    }
                    temp.notifyListeners();
                  }
                }
              },
              controller: searchController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                hintText: 'Search',
              ),
            ),
          ),
        ),
        body: Container(
          color: const Color.fromARGB(255, 19, 40, 85),
          child: ValueListenableBuilder(
            valueListenable: temp,
            builder: (BuildContext ctx, List<StudentModel> searchdata,
                Widget? child) {
              return ListView.separated(
                itemBuilder: (ctx, index) {
                  final data = searchdata[index];
                  return ListTile(
                    title: Text(
                      data.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ScreenStudentDetails(
                            studentmodel: data,
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider();
                },
                itemCount: searchdata.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
