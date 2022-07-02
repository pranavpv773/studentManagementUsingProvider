import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:student_management/db/db_functions.dart';
import 'package:student_management/model/data_model.dart';

class ScreenEdit extends StatefulWidget {
  final StudentModel studentmdoel;

  const ScreenEdit({Key? key, required this.studentmdoel}) : super(key: key);

  @override
  State<ScreenEdit> createState() => _ScreenEditState();
}

class _ScreenEditState extends State<ScreenEdit> {
  final nameUpdateController = TextEditingController();

  final ageUpdateController = TextEditingController();

  final phoneUpdateController = TextEditingController();

  final placeUpdateController = TextEditingController();

  File? imagefile;

  @override
  Widget build(BuildContext context) {
    nameUpdateController.text = widget.studentmdoel.name;
    ageUpdateController.text = widget.studentmdoel.age;
    phoneUpdateController.text = widget.studentmdoel.phoneNumber;
    placeUpdateController.text = widget.studentmdoel.place;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
        ),
        body: Container(
          color: const Color.fromARGB(255, 19, 40, 85),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Center(
                    child: Text(
                  'EDIT',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
                CircleAvatar(
                  radius: 40,
                  child: imageprofile(context),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: nameUpdateController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255),
                          width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: ageUpdateController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255),
                          width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phoneUpdateController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255),
                          width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: placeUpdateController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255),
                          width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.pink),
                    ),
                    onPressed: () {
                      updateStudent();
                    },
                    child: const Text('Update'))
              ],
            ),
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
            child: Column(
              children: [
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
              ],
            ),
          ),
        );
      },
    );
  }

  Widget imageprofile(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 40,
          child: imgstring.trim().isEmpty
              ? CircleAvatar(
                  radius: 50,
                  backgroundImage: MemoryImage(
                    const Base64Decoder().convert(widget.studentmdoel.imgstri),
                  ),
                )
              : Container(
                  color: Colors.white,
                ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 18),
          child: IconButton(
            onPressed: () {
              showBottomSheet(context);
            },
            icon: const Icon(
              Icons.camera_alt,
              color: Color.fromARGB(255, 236, 236, 236),
              size: 20,
            ),
          ),
        )
      ],
    );
  }

  Future<void> updateStudent() async {
    final name = nameUpdateController.text;
    final age = ageUpdateController.text;
    final phone = phoneUpdateController.text;
    final places = placeUpdateController.text;

    if (name.isEmpty || age.isEmpty || phone.isEmpty || places.isEmpty) {
      return;
    } else {
      final studentup = StudentModel(
          name: name,
          age: age,
          phoneNumber: phone,
          place: places,
          imgstri: imgstring,
          id: widget.studentmdoel.id);

      if (studentup.id != null) {
        await studentupdate(studentup.id!, studentup);
        imgstring = '';
      }
    }
  }
}
