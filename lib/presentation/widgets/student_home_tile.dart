import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/database/db_functions.dart';
import 'package:provider/provider.dart';

import '../../core/colors.dart';
import '../../domain/model/data_model.dart';
import '../screens/student_details_screen.dart';

class StudentHomeTile extends StatelessWidget {
  const StudentHomeTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final StudentModel data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        data.name,
        style: TextStyle(
          color: kWhite,
        ),
      ),
      subtitle: Text(
        data.age,
        style: TextStyle(
          color: kWhite,
        ),
      ),
      leading: CircleAvatar(
        radius: 40,
        child: context.read<StudentDbFunctions>().imgstring.isEmpty
            ? CircleAvatar(
                radius: 50,
                backgroundImage: MemoryImage(
                  const Base64Decoder().convert(
                    data.imgstri,
                  ),
                ),
              )
            : Container(
                color: kWhite,
              ),
      ),
      trailing: IconButton(
        color: kPink,
        onPressed: () {
          if (data.id != null) {
            Provider.of<StudentDbFunctions>(context, listen: false)
                .deleteStudent(
              data.id!,
            );
          }
        },
        icon: const Icon(
          Icons.delete,
        ),
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
  }
}
