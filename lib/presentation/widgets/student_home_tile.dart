import 'dart:convert';

import 'package:flutter/material.dart';

import '../../domain/model/data_model.dart';

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
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        data.age,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      leading: CircleAvatar(
        radius: 40,
        child: data.imgstri.isEmpty
            ? CircleAvatar(
                radius: 50,
                backgroundImage: MemoryImage(
                  const Base64Decoder().convert(
                    data.imgstri,
                  ),
                ),
              )
            : Container(
                color: Colors.white,
              ),
      ),
      trailing: IconButton(
        color: Colors.pink,
        onPressed: () {
          // if (data.id != null) {
          //   deleteStudent(data.id!);
          // }
        },
        icon: const Icon(Icons.delete),
      ),
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (ctx) => ScreenStudentDetails(
        //       studentmodel: studentList[index],
        //     ),
        //   ),
        // );
      },
    );
  }
}
