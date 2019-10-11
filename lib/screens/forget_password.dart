import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //widget에 key를 부여
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget password'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Email',
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return "Please input correct Email.";
                }
                return null;
              },
            ),
            FlatButton(
              onPressed: () async {
                await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
                final snackbar = SnackBar(content: Text('Check your email for password reset'));
                Scaffold.of(_formKey.currentContext).showSnackBar(snackbar);
              },
              child: Text('Reset Password')
            )
          ],
        ),
      ),
    );
  }
}
