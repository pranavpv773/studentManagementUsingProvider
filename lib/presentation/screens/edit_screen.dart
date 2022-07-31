import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/database/db_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../core/colors.dart';
import '../../domain/model/data_model.dart';
import '../widgets/text_widget.dart';
import 'home_screen.dart';

class StudentEditScreen extends StatelessWidget {
  StudentEditScreen({Key? key, required this.studentmodel}) : super(key: key);
  final _formkey = GlobalKey<FormState>();
  final StudentModel studentmodel;

  final nameUpdateController = TextEditingController();

  final ageUpdateController = TextEditingController();

  final phoneUpdateController = TextEditingController();

  final placeUpdateController = TextEditingController();

  File? imagefile;

  @override
  Widget build(BuildContext context) {
    nameUpdateController.text = studentmodel.name;
    ageUpdateController.text = studentmodel.age;
    phoneUpdateController.text = studentmodel.phoneNumber;
    placeUpdateController.text = studentmodel.place;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPink,
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
                Form(
                  key: _formkey,
                  child: const Center(
                    child: TextWidget(
                      title: 'edit',
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 40,
                  child: imageprofile(context),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: nameUpdateController,
                  style: TextStyle(
                    color: kWhite,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: klightWhite,
                        width: 2.0,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: ageUpdateController,
                  style: TextStyle(
                    color: kWhite,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: klightWhite,
                        width: 2.0,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phoneUpdateController,
                  style: TextStyle(
                    color: kWhite,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: klightWhite,
                        width: 2.0,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: placeUpdateController,
                  style: TextStyle(
                    color: kWhite,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: klightWhite,
                        width: 2.0,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      kPink,
                    ),
                  ),
                  onPressed: () {
                    updateStudent();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx1) => const StudentHomeScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Update',
                  ),
                )
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

    final imageTemprary = File(image.path);
    imagefile = imageTemprary;
    Provider.of<StudentDbFunctions>(_formkey.currentState!.context,
            listen: false)
        .imageadd(image);
  }

  Future<void> takecamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) return;

    final imageTemprary = File(image.path);
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
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
          child: StudentDbFunctions().imgstring.trim().isEmpty
              ? CircleAvatar(
                  radius: 50,
                  backgroundImage: MemoryImage(
                    const Base64Decoder().convert(studentmodel.imgstri),
                  ),
                )
              : Container(
                  color: kWhite,
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
        imgstri: "",
        id: studentmodel.id,
      );

      if (studentup.id != null) {
        await Provider.of<StudentDbFunctions>(
          _formkey.currentState!.context,
          listen: false,
        ).studentupdate(studentup.id!, studentup);
      }
    }
  }
}
