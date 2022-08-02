import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/database/db_functions.dart';
import 'package:flutter_application_1/presentation/screens/login_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'domain/model/data_model.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Ensure plugin services are initialized
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(
    const StudentManagement(),
  );
}

class StudentManagement extends StatelessWidget {
  const StudentManagement({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StudentDbFunctions(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
