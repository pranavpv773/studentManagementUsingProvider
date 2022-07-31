// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/colors.dart';
import 'package:flutter_application_1/domain/database/db_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../domain/model/data_model.dart';
import 'home_screen.dart';

class StudentAddScreen extends StatelessWidget {
  StudentAddScreen({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _phoneNumberController = TextEditingController();

  final _placeController = TextEditingController();

  File? imagefile;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPink,
        ),
        body: Container(
          padding: const EdgeInsets.all(
            20,
          ),
          color: const Color.fromARGB(255, 19, 40, 85),
          child: ListView(
            children: [
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Text(
                      'Add Student',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: kWhite,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: imageprofile(context),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _nameController,
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: klightWhite,
                            width: 2.0,
                          ),
                        ),
                        hintText: 'Enter Student Name',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: klightWhite,
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _ageController,
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: klightWhite,
                            width: 2.0,
                          ),
                        ),
                        hintText: 'Enter Age',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: klightWhite,
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _phoneNumberController,
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: klightWhite,
                            width: 2.0,
                          ),
                        ),
                        hintText: 'Enter the Number',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: klightWhite,
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _placeController,
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: klightWhite,
                            width: 2.0,
                          ),
                        ),
                        hintText: 'Enter Place',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: klightWhite,
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          kPink,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              18.0,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Student Added Successfully....',
                              ),
                            ),
                          );
                        }
                        onAddStudentButtonClicked();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx1) => const StudentHomeScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Add Student',
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//-------------------------------------|||||Functions||||||------------------------------------------------------------------------------------

  Future<void> takePhoto() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    File imageTemprary = File(image.path);
    imagefile = imageTemprary;
    Provider.of<StudentDbFunctions>(_formkey.currentState!.context,
            listen: false)
        .imageadd(image);
  }

  Future<void> takecamera() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (image == null) {
      return;
    }

    File imageTemprary = File(
      image.path,
    );
    imagefile = imageTemprary;
    Provider.of<StudentDbFunctions>(_formkey.currentState!.context,
            listen: false)
        .imageadd(image);
  }

  Future<void> showBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (ctx1) {
        return Container(
          height: 100,
          width: double.infinity,
          color: kPink,
          child: Padding(
            padding: const EdgeInsets.all(
              8.0,
            ),
            child: Column(children: [
              Text(
                'choose your profile photo',
                style: TextStyle(
                  color: kWhite,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      takecamera();
                    },
                    icon: Icon(
                      Icons.camera_front_outlined,
                      color: kWhite,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      takePhoto();
                    },
                    icon: Icon(
                      Icons.image_rounded,
                      color: kWhite,
                    ),
                  )
                ],
              )
            ]),
          ),
        );
      },
    );
  }

  Widget imageprofile(BuildContext context) {
    return Stack(
      children: [
        imagefile != null
            ? Image.file(
                imagefile!,
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              )
            : Image.asset(
                'assets/avathar.png',
                width: 250,
                height: 250,
              ),
        Padding(
          padding: const EdgeInsets.only(
            top: 150,
            left: 150,
          ),
          child: IconButton(
            onPressed: () {
              showBottomSheet(context);
            },
            icon: Icon(
              Icons.camera_alt,
              color: kPink,
              size: 80,
            ),
          ),
        )
      ],
    );
  }

  Future<void> onAddStudentButtonClicked() async {
    final name = _nameController.text;
    final age = _ageController.text;
    final phoneNumber = _phoneNumberController.text;
    final place = _placeController.text;
    if (name.isEmpty || age.isEmpty || phoneNumber.isEmpty || place.isEmpty) {
      return;
    } else {
      final _student = StudentModel(
        name: name,
        age: age,
        phoneNumber: phoneNumber,
        place: place,
        imgstri: StudentDbFunctions().imgstring,
      );

      Provider.of<StudentDbFunctions>(_formkey.currentState!.context,
              listen: false)
          .addStudent(_student);
    }
  }
}
