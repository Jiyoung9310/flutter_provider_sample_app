import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //widget에 key를 부여
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  //디바이스 크기 가져오기
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(color: Colors.red,), // 배경
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(margin: EdgeInsets.all(50.0),width: 200, height: 200, color: Colors.amber,), //
              Stack(
                children: <Widget>[
                  Form(
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
                            if(value.isEmpty) {
                              return "Please input correct Email.";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.vpn_key),
                            labelText: 'Password',
                          ),
                          validator: (String value) {
                            if(value.isEmpty) {
                              return "Please input correct Password.";
                            }
                            return null;
                          },
                        ),
                        Text("Forgot Password"),
                      ],
                    ),),
//                      Container(width: 100, height: 50, color: Colors.black,),
                ],),
              Container(height: size.height*0.1,),
              Text('텍스트 들어갈 자리'),
              Container(height: size.height*0.05,),
            ],
          ),
        ],
      ),
    );
  }
}
