import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../model/data_model.dart';

class StudentDbFunctions with ChangeNotifier {
  List<StudentModel> studentlistNotifier = [];

  void addStudent(StudentModel value) async {
    final studentDb = await Hive.openBox<StudentModel>('student_db');
    final _id = await studentDb.add(value);
    value.id = _id;
    await studentDb.put(value.id, value);
    notifyListeners();
  }

  getallStudents() async {
    final studentDb = await Hive.openBox<StudentModel>('student_db');
    studentlistNotifier.clear();
    studentlistNotifier.addAll(studentDb.values);
    notifyListeners();
  }

  deleteStudent(int id) async {
    final studentDb = await Hive.openBox<StudentModel>('student_db');
    await studentDb.delete(id);
    getallStudents();
    notifyListeners();
  }

  studentupdate(int id, StudentModel value) async {
    final studentDb = await Hive.openBox<StudentModel>('student_db');
    await studentDb.put(id, value);
    getallStudents();
    notifyListeners();
  }

  File? imagefile;
  String imgstring = '';
  changeImage(String imgstring) {
    this.imgstring = imgstring;
    notifyListeners();
  }

  // imageadd(XFile? pickImage) {
  //   if (pickImage == null) {
  //     print("pickImage NULL");
  //     return 'assets/download.png';
  //   } else {
  //     final bayts = File(pickImage.path).readAsBytesSync();
  //     imgstring = base64Encode(bayts);
  //     print("imageFunction:$imgstring");
  //   }
  //   notifyListeners();
  // }
}
