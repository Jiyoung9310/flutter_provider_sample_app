import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatelessWidget {
  MainPage({this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(email),
      ),
      body: Container(
        child: Center(
          child: FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: Text('logout'),
          ),
        )
      ),
    );
  }
}
