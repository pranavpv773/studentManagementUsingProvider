import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/colors.dart';
import 'package:flutter_application_1/domain/database/db_functions.dart';
import 'package:flutter_application_1/presentation/screens/add_screen.dart';
import 'package:flutter_application_1/presentation/widgets/student_home_tile.dart';
import 'package:provider/provider.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<StudentDbFunctions>(context, listen: false)
            .getallStudents();
      },
    );
    context.read<StudentDbFunctions>().imgstring = '';
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Teacher's Record"),
          backgroundColor: kPink,
          actions: [
            IconButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (ctx) => ScreenSearch(),
                //   ),
                // );
              },
              icon: const Icon(
                Icons.search,
              ),
            )
          ],
        ),
        body: Container(
          color: kBackground,
          child: Consumer<StudentDbFunctions>(
            builder: (context, value, child) {
              if (value.studentlistNotifier.isEmpty) {
                return const Center(
                  child: Text(
                    "No Data found",
                  ),
                );
              }
              return ListView.separated(
                itemBuilder: (ctx, index) {
                  return StudentHomeTile(
                    data: value.studentlistNotifier[index],
                  );
                },
                separatorBuilder: (ctx, index) {
                  return Divider(
                    color: kWhite,
                    indent: 15,
                    endIndent: 10,
                    thickness: 3,
                  );
                },
                itemCount: value.studentlistNotifier.length,
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: kPink,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) {
                  return StudentAddScreen();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
