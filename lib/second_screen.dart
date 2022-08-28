import 'package:firebase_auth2_4/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SecondScreen extends StatelessWidget {
  SecondScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController scoreController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final User? user = firebaseAuth.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Data'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  //prefixIcon: Icon(Iconsname),
                  //hintText: 'Name',
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: genderController,
                decoration: const InputDecoration(
                  //prefixIcon: Icon(Icons.password),
                  //hintText: 'Old password',
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: scoreController,
                decoration: const InputDecoration(
                  //prefixIcon: Icon(Icons.password),
                  //hintText: 'New password',
                  labelText: 'Score',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {},
                child: const SizedBox(
                    height: 45,
                    width: 100,
                    child: Center(child: Text('InserData')))),
          ],
        ),
      ),
    );
  }

  void createData() async {
    // if(_formKey.currentState)
  }
}
