import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/db/db_functions.dart';
import 'package:student_management/model/data_model.dart';

class ScreenAdd extends StatefulWidget {
  const ScreenAdd({Key? key}) : super(key: key);

  @override
  State<ScreenAdd> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAdd> {
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
          backgroundColor: Colors.pink,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          color: const Color.fromARGB(255, 19, 40, 85),
          child: ListView(
            children: [
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    const Text(
                      'Add Student',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: 2.0),
                        ),
                        hintText: 'Enter Student Name',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        border: OutlineInputBorder(),
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
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: 2.0),
                        ),
                        hintText: 'Enter Age',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        border: OutlineInputBorder(),
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
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 2.0,
                          ),
                        ),
                        hintText: 'Enter the Number',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        border: OutlineInputBorder(),
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
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 2.0),
                          ),
                          hintText: 'Enter Place',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.pink),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Student Added Successfully....')),
                            );
                          }
                          onAddStudentButtonClicked();
                        },
                        child: const Text('Add Student'))
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
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    File imageTemprary = File(image.path);
    setState(() {
      imagefile = imageTemprary;
    });
    imageadd(image);
  }

  Future<void> takecamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) return;

    final imageTemprary = File(image.path);
    setState(() {
      imagefile = imageTemprary;
    });
    imageadd(image);
  }

  Future<void> showBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (ctx1) {
        return Container(
          height: 100,
          width: double.infinity,
          color: Colors.pink,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              const Text(
                'choose your profile photo',
                style: TextStyle(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      takecamera();
                    },
                    icon: const Icon(
                      Icons.camera_front_outlined,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      takePhoto();
                    },
                    icon: const Icon(
                      Icons.image_rounded,
                      color: Colors.white,
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
            : Image.asset('assets/avathar.png', width: 250, height: 250),
        Padding(
          padding: const EdgeInsets.only(top: 150, left: 150),
          child: IconButton(
            onPressed: () {
              showBottomSheet(context);
            },
            icon: const Icon(
              Icons.camera_alt,
              color: Colors.pink,
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
        imgstri: imgstring,
      );

      addStudent(_student);
      imgstring = '';
    }
  }
}
