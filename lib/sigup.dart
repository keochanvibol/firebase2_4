import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth2_4/controllers/auth_controller.dart';
import 'package:firebase_auth2_4/main.dart';
import 'package:firebase_auth2_4/models/auth_model.dart';
import 'package:firebase_auth2_4/second_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SigUpPage extends StatefulWidget {
  const SigUpPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SigUpPage> createState() => _SigUpPageState();
}

class _SigUpPageState extends State<SigUpPage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: mailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  hintText: 'Enter Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: 'Enter password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  var message = Sigup(mailController.text.trim(),
                      passwordController.text.trim());
                  if (await message == 'success') {
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyHomePage(title: 'LoginPage')),
                        (route) => false);
                  } else {
                    print('object data not found..!!!');
                  }
                },
                child: const SizedBox(
                    height: 45,
                    width: 100,
                    child: Center(child: Text('SigUp'))))
          ],
        ),
      ),
    );
  }

  Future<String?> Sigup(String email, String password) async {
    String message = 'message';
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      message = 'success';

      //  print('signIn');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          message = e.code;
          break;
        case 'invalid-password':
          message = e.code;
          break;
        case 'wrong-password':
          message = e.code;
          break;
        case 'user-not-found':
          message = e.code;
          break;
      }
      print(e);
    }
    return message;
  }
}
