import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/colors.dart';
import 'package:flutter_application_1/presentation/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _userName = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              backgroundImage,
            ),
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 55,
              ),
              child: Image(
                image: NetworkImage(
                  teacherImage,
                ),
                height: 250,
              ),
            ),
            Card(
              color: Colors.transparent,
              margin: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
              ),
              child: Column(
                children: [
                  TextButton(
                    onPressed: (() {}),
                    child: Padding(
                      padding: const EdgeInsets.all(
                        8.0,
                      ),
                      child: Text(
                        'New User? Create Account',
                        style: TextStyle(
                          color: kWhite,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      controller: _userName,
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: klightWhite,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.teal,
                            width: 2.0,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                        labelText: 'User Name',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: klightWhite,
                        ),
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: klightWhite,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      controller: _password,
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 18,
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: klightWhite,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.teal,
                            width: 2.0,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: klightWhite,
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: klightWhite,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password ?',
                      style: TextStyle(
                        color: klightWhite,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 110,
                        vertical: 10,
                      ),
                      primary: const Color.fromARGB(209, 206, 30, 104),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                    ),
                    onPressed: (() {
                      checkLogin(context);
                    }),
                    child: const Text(
                      'Login',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

//-------------------------------------|||||Functions||||||------------------------------------------------------------------------------------

  void checkLogin(BuildContext ctx) async {
    final _user = _userName.text;
    final _pass = _password.text;
    if (_user == 'School' && _pass == 'admin') {
      Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(
          builder: (ctx1) => const StudentHomeScreen(),
        ),
      );
    } else {
      const _errorMsg = "Invalid Username OR Password!!!";
      showDialog(
        context: ctx,
        builder: (ctx1) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text(
              _errorMsg,
              style: TextStyle(color: Colors.red),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx1).pop();
                },
                child: const Text(
                  'Close',
                ),
              )
            ],
          );
        },
      );
    }
  }
}
