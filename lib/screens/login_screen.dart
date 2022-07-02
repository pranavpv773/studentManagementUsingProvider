import 'package:flutter/material.dart';
import 'package:student_management/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _userName = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              'https://i.pinimg.com/originals/24/e9/d9/24e9d9fe3469d58936be626c7781bf0c.jpg',
            ),
          ),
        ),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 55),
              child: Image(
                image: NetworkImage(
                  'https://pngimg.com/uploads/teacher/teacher_PNG13.png',
                ),
                height: 250,
              ),
            ),
            Card(
              color: Colors.transparent,
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  TextButton(
                    onPressed: (() {}),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'New User? Create Account',
                        style: TextStyle(color: Colors.white),
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
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.teal, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 255, 255),
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
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      obscureText: true,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.teal, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password ?',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: (() {
                      checkLogin(context);
                    }),
                    child: const Text('Login'),
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
          builder: (ctx1) => const ScreenHome(),
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
                child: const Text('Close'),
              )
            ],
          );
        },
      );
    }
  }
}
