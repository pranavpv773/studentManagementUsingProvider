// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import '../../core/colors.dart';
// import '../../domain/database/db_functions.dart';

// class ImageProfile extends StatelessWidget {
//   const ImageProfile({Key? key, required this.image}) : super(key: key);
//   final String image;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         CircleAvatar(
//           radius: 40,
//           child: StudentDbFunctions().imgstring.trim().isEmpty
//               ? CircleAvatar(
//                   radius: 50,
//                   backgroundImage: MemoryImage(
//                     const Base64Decoder().convert(image),
//                   ),
//                 )
//               : Container(
//                   color: kWhite,
//                 ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 20, left: 18),
//           child: IconButton(
//             onPressed: () {
//               showBottomSheet(context);
//             },
//             icon: const Icon(
//               Icons.camera_alt,
//               color: Color.fromARGB(255, 236, 236, 236),
//               size: 20,
//             ),
//           ),
//         )
//       ],
//     );
//   }
//    Future<void> showBottomSheet(BuildContext context) async {
//     showModalBottomSheet(
//       context: context,
//       builder: (ctx1) {
//         return Container(
//           height: 100,
//           width: double.infinity,
//           color: kPink,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 Text(
//                   'choose your profile photo',
//                   style: TextStyle(
//                     color: kWhite,
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         takecamera();
//                       },
//                       icon: Icon(
//                         Icons.camera_front_outlined,
//                         color: kWhite,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         takePhoto();
//                       },
//                       icon: Icon(
//                         Icons.image_rounded,
//                         color: kWhite,
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//   //-------------------------------------|||||Functions||||||------------------------------------------------------------------------------------

//   Future<void> takePhoto() async {
//     XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (image == null) return;

//     final imageTemprary = File(image.path);
//     imagefile = imageTemprary;
//     Provider.of<StudentDbFunctions>(_formkey.currentState!.context,
//             listen: false)
//         .imageadd(image);
//   }

//   Future<void> takecamera() async {
//     XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

//     if (image == null) return;

//     final imageTemprary = File(image.path);
//     imagefile = imageTemprary;
//     Provider.of<StudentDbFunctions>(_formkey.currentState!.context,
//             listen: false)
//         .imageadd(image);
//   }

// }
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../core/colors.dart';
import '../../domain/database/db_functions.dart';

class ImageProfile extends StatelessWidget {
  const ImageProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Provider.of<StudentDbFunctions>(context, listen: true)
                .imgstring
                .isNotEmpty
            ? Consumer<StudentDbFunctions>(
                builder: (context, value, child) {
                  return Image.memory(
                    const Base64Decoder().convert(
                      value.imgstring,
                    ),
                    // Provider.of<StudentDbFunctions>(context, listen: false)
                    //     .imagefile!,
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  );
                },
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

  Future<void> takePhoto(BuildContext context) async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    Provider.of<StudentDbFunctions>(context, listen: false).imagefile =
        File(image.path);

    final bayts = File(image.path).readAsBytesSync();
    String encode = base64Encode(bayts);
    context.read<StudentDbFunctions>().changeImage(encode);
    base64Encode(bayts);
  }

  Future<void> takecamera(BuildContext context) async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (image == null) {
      return;
    }

    Provider.of<StudentDbFunctions>(context, listen: false).imagefile =
        File(image.path);

    final bayts = File(image.path).readAsBytesSync();
    String encode = base64Encode(bayts);
    context.read<StudentDbFunctions>().changeImage(encode);
    base64Encode(bayts);
  }

  Future<void> showBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
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
                      takecamera(context);
                    },
                    icon: Icon(
                      Icons.camera_front_outlined,
                      color: kWhite,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      takePhoto(context);
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
}
