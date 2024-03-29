import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/data/join_or_login.dart';
import 'package:flutter_sample_app/helper/login_background.dart';
import 'package:provider/provider.dart';
import 'forget_password.dart';

class AuthPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //widget에 key를 부여
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; //디바이스 크기 가져오기
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomPaint(
            size: size,
            painter: LoginBackground(isJoin : Provider.of<JoinOrLogin>(context).isJoin),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _logoImage,
              Stack(
                children: <Widget>[
                  _inputForm(size),
                  _authButton(size),
                ],
              ),
              Container(
                height: size.height * 0.1,
              ),
              Consumer<JoinOrLogin>(
                builder: (context, joinOrLogin, child) =>
                    GestureDetector(
                        onTap: () {
                          joinOrLogin.toggle();
                        },
                        child: Text(joinOrLogin.isJoin ? "Are you have an account? Sign in" : "Don't Have an Account? Create One",
                          style: TextStyle(color: joinOrLogin.isJoin? Colors.red : Colors.blue),)),
              ),
              Container(
                height: size.height * 0.05,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _register(BuildContext context) async {
    final AuthResult result
    = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text)
        .catchError((e) {
      _showSnackBar(context, "${e.message}");
    });
    
    final FirebaseUser user = result.user;

    if(user == null) {
      _showSnackBar(context, 'Please try again.');

    }

  }

  void _showSnackBar(BuildContext context, String msg) {
    final snackbar = SnackBar(content: Text(msg));
    Scaffold.of(context).showSnackBar(snackbar);
  }

  void _login(BuildContext context) async {
    final AuthResult result
    = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text)
        .catchError((e) {
      _showSnackBar(context, "${e.message}");
    });
    final FirebaseUser user = result.user;

    if(user == null) {
      _showSnackBar(context, 'Please try again.');
    }

  }

  Expanded get _logoImage => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 24, right: 24),
          child: FittedBox(
            fit: BoxFit.contain,
            child: CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/profile.gif",
              ),
            ),
          ),
        ),
      );

  Positioned _authButton(Size size) {
    return Positioned(
      left: size.width * 0.15,
      right: size.width * 0.15,
      bottom: 0,
      child: SizedBox(
        height: 50,
        child: Consumer<JoinOrLogin>(
          builder: (context, value, child)=> RaisedButton(
            color: value.isJoin ? Colors.red : Colors.blue,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: Text(value.isJoin ? 'Join' : 'Login', style: TextStyle(fontSize: 20, color: Colors.white),),
            onPressed: () {
              if(_formKey.currentState.validate()) {
                value.isJoin ? _register(context) : _login(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Padding _inputForm(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6.0,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 12.0, right: 12.0, top: 12.0, bottom: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    labelText: 'Password',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please input correct Password.";
                    }
                    return null;
                  },
                ),
                Container(
                  height: 10,
                ),
                Consumer<JoinOrLogin>(
                  builder: (context, value, child) => Opacity(
                      opacity: value.isJoin? 0 : 1,
                      child: GestureDetector(
                          onTap: value.isJoin ? null : () {
                            Navigator.push(context, MaterialPageRoute(builder:
                                (context) => _goToForgetPassword()));
                          },
                          child: Text("Forgot Password"))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ForgetPassword _goToForgetPassword() => ForgetPassword();
}
