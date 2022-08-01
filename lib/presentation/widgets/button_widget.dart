// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/domain/database/db_functions.dart';
// import 'package:provider/provider.dart';

// import '../../domain/model/data_model.dart';

// class DetailAddingScreen extends StatelessWidget {
//   DetailAddingScreen({
//     Key? key,
//     this.type,
//     this.data,
//   }) : super(key: key);

//   final ActionType? type;
//   final StudentModel? data;

//   final _formkey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _numController = TextEditingController();
//   final _placeController = TextEditingController();

  

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       Provider.of<StudentModelFunction>(context, listen: false).getAllStudent();
//       context.read<ImageController>().imagess = '';
//     });
//     if (type == ActionType.editStudent) {
//       _nameController.text = data!.name;
//       _ageController.text = data!.age;
//       _numController.text = data!.phoneNumber;
//       _placeController.text = data!.place;
//     }
//     return Scaffold(
//       appBar: PreferredSize(
//           preferredSize: Size.fromHeight(50),
//           child: WidgetAppBar(
//             title:
//                 type == ActionType.addStudent ? "Add new student" : data!.name,
//             iconButton: Icons.star,
//             iconColor: const Color.fromARGB(255, 236, 214, 18),
//           )),
//       body: SafeArea(
//           child: Consumer<StudentDbFunctions>(
//         builder: (context, value, child) => ListView(
//           children: [
//             Form(
//                 key: _formkey,
//                 child: Column(
//                   children: [
                    
//                     Consumer<StudentDbFunctions>(
//                       builder: (context, imge, child) {
//                         return Stack(
//                           children: [
//                             imge.imgstring.isEmpty
//                                 ? const CircleAvatar(
//                                     radius: 80,
//                                     backgroundColor: Color.fromRGBO(0, 0, 0, 0),
//                                     backgroundImage:
//                                         AssetImage("images/download.png"))
//                                 : CircleAvatar(
//                                     radius: 80,
//                                     backgroundImage: MemoryImage(Base64Decoder()
//                                         .convert(imge.imgstring.toString())),
//                                   ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(top: 100, left: 110),
//                               child: IconButton(
//                                   onPressed: () {
//                                     showBottomSheet(context);
//                                   },
//                                   icon: const Icon(
//                                     Icons.camera_alt,
//                                     color: Colors.red,
//                                     size: 50,
//                                   )),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
                    
//                     TextFieldWidget(
//                         hint: "Enter student name", control: _nameController),
                    
//                     TextFieldWidget(hint: "Enter age", control: _ageController),
                    
//                     TextFieldWidget(
//                         hint: "Phone number", control: _numController),
                   
//                     TextFieldWidget(hint: "Place", control: _placeController),
                    
//                   ],
//                 )),
//           ],
//         ),
//       )),
//       bottomNavigationBar: GestureDetector(
//         onTap: () {
//           print("object");
//           switch (type) {
//             case ActionType.addStudent:
//               if (_formkey.currentState!.validate()) {
//                 ScaffoldMessenger.of(_formkey.currentState!.context)
//                     .showSnackBar(
//                   SnackBar(
//                       content: Text(
//                           "Student${_nameController.text}  added to Students")),
//                 );
//                 onSaveButtonClicked(context);
//               }

//               break;
//             case ActionType.editStudent:
//               if (_formkey.currentState!.validate()) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Student ${data!.name} editted")));
//               }
//               onUpdateButtonClicked(context);
//               break;
//           }
//         },
//         child: BottomBarWidget(
//           title: type == ActionType.addStudent ? "Save" : "update",
//         ),
//       ),
//     );
//   }

//   Future showBottomSheet(ctx1) async {
//     showModalBottomSheet(
//         context: ctx1,
//         builder: (context) {
//           return Container(
//             height: 80,
//             width: double.infinity,
//             color: const Color.fromARGB(62, 0, 0, 0),
//             child: Column(
//               children: [
//                 const Text('choise your profile photo'),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Consumer<ImageController>(
//                       builder: (context, value, child) {
//                         return IconButton(
//                             onPressed: () async {
//                               value.pickImageFromCamera();
//                               Navigator.of(context).pop();
//                             },
//                             icon: const Icon(
//                               Icons.camera,
//                               size: 30,
//                             ));
//                       },
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           takePhoto();
//                         },
//                         icon: const Icon(
//                           Icons.sd_storage,
//                           size: 30,
//                         ))
//                   ],
//                 )
//               ],
//             ),
//           );
//         });
//   }

//   Future takePhoto() async {
//     await ImagePicker().pickImage(source: ImageSource.gallery);
//   }

//   Future onSaveButtonClicked(context) async {
//     final name = _nameController.text;
//     final age = _ageController.text;
//     final phoneNumber = _numController.text;
//     final place = _placeController.text;

//     if (name.isEmpty || age.isEmpty || phoneNumber.isEmpty || place.isEmpty) {
//       return;
//     } else {
//       final student = StudentModel(
//           name: name,
//           age: age,
//           phoneNumber: phoneNumber,
//           place: place,
//           imgstri:
//               Provider.of<ImageController>(context, listen: false).imagess);
//       Provider.of<StudentModelFunction>(context, listen: false)
//           .addStudent(student);
//       Provider.of<ImageController>(context, listen: false).imagess = '';
//       Navigator.of(_formkey.currentContext!).pop();
//     }
//   }

//   void onUpdateButtonClicked(context) {
//     final nameEditted = _nameController.text;
//     final ageEditted = _ageController.text;
//     final phoneNumberEditted = _numController.text;
//     final placeEditted = _placeController.text;

//     if (nameEditted.isEmpty ||
//         ageEditted.isEmpty ||
//         phoneNumberEditted.isEmpty ||
//         placeEditted.isEmpty) {
//       return;
//     } else {
//       final studentEditted = StudentModel(
//           name: nameEditted,
//           age: ageEditted,
//           phoneNumber: phoneNumberEditted,
//           place: placeEditted,
//           imgstri: Provider.of<StudentDbFunctions>(context, listen: false).imagess,
//           id: data!.id);
//       Provider.of<StudentDbFunctions>(_formkey.currentState!.context,
//               listen: false)
//           .updateStudent(studentEditted.id!, studentEditted);
//       Navigator.of(_formkey.currentContext!).pop();
//     }
//   }
// }
// Footer
