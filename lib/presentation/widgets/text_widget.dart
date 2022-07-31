import 'package:flutter/material.dart';

import '../../core/colors.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 59,
        fontWeight: FontWeight.bold,
        color: kWhite,
      ),
    );
  }
}
