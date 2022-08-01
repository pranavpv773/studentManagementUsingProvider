import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/model/data_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../core/colors.dart';
import '../../domain/database/db_functions.dart';

class ImageProfileEdit extends StatelessWidget {
  const ImageProfileEdit({Key? key, required this.studentModel})
      : super(key: key);
  final String studentModel;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 40,
          child: Provider.of<StudentDbFunctions>(context, listen: true)
                  .imgstring
                  .isEmpty
              ? Consumer<StudentDbFunctions>(
                  builder: (context, value, child) {
                    return GestureDetector(
                      onTap: () {
                        showBottomSheet(context);
                      },
                      child: Image.memory(
                        const Base64Decoder().convert(
                          studentModel,
                        ),
                        // Provider.of<StudentDbFunctions>(context, listen: false)
                        //     .imagefile!,
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
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
