import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  Color nameColor = Color.fromARGB(0xFF, 0x55, 0x8b, 0x2f);
  Color emailColor = Colors.orange.shade900;
  Color passwordColor = Colors.blueGrey[700];

  // Method

  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Display Name :',
        labelStyle: TextStyle(color: nameColor),
        helperText: 'Type Your Name',
        helperStyle: TextStyle(color: nameColor),
        hintText: 'English Only',
        icon: Icon(
          Icons.face,
          size: 36.0,
          color: nameColor,
        ),
      ),
    );
  }

  Widget emailText() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email :',
        labelStyle: TextStyle(color: emailColor),
        helperText: 'Type Your Email',
        helperStyle: TextStyle(color: emailColor),
        hintText: 'you@email.com',
        icon: Icon(
          Icons.email,
          size: 36.0,
          color: emailColor,
        ),
      ),
    );
  }

  Widget passwordText() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password :',
        labelStyle: TextStyle(color: passwordColor),
        helperText: 'Type Your Password',
        helperStyle: TextStyle(color: passwordColor),
        hintText: 'More 6 Charactor',
        icon: Icon(
          Icons.lock,
          size: 36.0,
          color: passwordColor,
        ),
      ),
    );
  }

  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[registerButton()],
        backgroundColor: Colors.pink[400],
        title: Text('Register'),
      ),
      body: ListView(
        padding: EdgeInsets.only(
          top: 60.0,
          left: 30.0,
          right: 30.0,
        ),
        children: <Widget>[
          nameText(),emailText(),passwordText(),
        ],
      ),
    );
  }
}
