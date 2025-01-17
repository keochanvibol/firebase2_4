import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth2_4/controllers/auth_controller.dart';
import 'package:firebase_auth2_4/forgotpass.dart';
import 'package:firebase_auth2_4/models/auth_model.dart';
import 'package:firebase_auth2_4/second_screen.dart';
import 'package:firebase_auth2_4/sigup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter FireBase'),
    );
  }
}

class MainPoinPage extends StatelessWidget {
  const MainPoinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SecondScreen();
            } else {
              return MyHomePage(title: 'LoginPage');
            }
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                  var message = login(mailController.text.trim(),
                      passwordController.text.trim());
                  if (await message == 'success') {
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondScreen()),
                    );
                  } else {
                    print('object data not found..!!!');
                  }
                },
                child: const SizedBox(
                    height: 45,
                    width: 100,
                    child: Center(child: Text('Log In')))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.red),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SigUpPage(title: 'SigUP Page')));
                    },
                    child: const Text('Sig Up')),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<String?> login(String email, String password) async {
    String message = 'message';
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
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
