import 'package:flutter/material.dart';

import '../../core/colors.dart';

class ButtonsWidget extends StatelessWidget {
  const ButtonsWidget({Key? key, required this.title, required this.onpressed})
      : super(key: key);
  final String title;
  final dynamic onpressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          kPink,
        ),
      ),
      onPressed: () {
        onpressed;
      },
      child: const Text(
        'Edit',
      ),
    );
  }
}
