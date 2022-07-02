// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentlistNotifier = ValueNotifier([]);

void addStudent(StudentModel value) async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  final _id = await studentDb.add(value);
  value.id = _id;
  await studentDb.put(value.id, value);
  studentlistNotifier.value.add(value);
  studentlistNotifier.notifyListeners();
}

getallStudents() async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  studentlistNotifier.value.clear();
  studentlistNotifier.value.addAll(studentDb.values);
  studentlistNotifier.notifyListeners();
}

deleteStudent(int id) async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  await studentDb.delete(id);
  getallStudents();
}

studentupdate(int id, StudentModel value) async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  await studentDb.put(id, value);
  getallStudents();
}

String imgstring = '';

imageadd(XFile? pickImage) async {
  if (pickImage == null) {
    return;
  } else {
    final bayts = File(pickImage.path).readAsBytesSync();
    imgstring = base64Encode(bayts);
  }
}
