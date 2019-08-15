import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ung_qr_code/screens/my_service.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String emailString, passwordString;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Color myBlue = Colors.blue.shade700;

  // Method
  Widget showAppName() {
    return Container(
      child: ListTile(
        leading: ImageIcon(
          AssetImage('images/logo.png'),
          color: myBlue,
          size: 36.0,
        ),
        title: Text(
          'Ung QR code',
          style: TextStyle(
            color: myBlue,
            fontSize: 20.0,
            fontFamily: 'IndieFlower',
          ),
        ),
      ),
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            size: 24.0,
            color: myBlue,
          ),
          labelText: 'Email :',
          labelStyle: TextStyle(color: myBlue)),
      onSaved: (String value) {
        emailString = value;
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: myBlue,
          ),
          labelText: 'Password :',
          labelStyle: TextStyle(color: myBlue)),
      onSaved: (String value) {
        passwordString = value;
      },
    );
  }

  Widget showTextField() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              showAppName(),
              emailText(),
              passwordText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget backButton() {
    return IconButton(
      icon: Icon(
        Icons.navigate_before,
        size: 36.0,color: Colors.white,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Future<void> checkAuthen() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }).catchError((response) {
      String errorString = response.message;
      mySnackBar(errorString);
    });
  }

  void mySnackBar(String messageString) {
    SnackBar snackBar = SnackBar(
      content: Text(messageString),
      backgroundColor: Colors.pink.shade600,
      duration: Duration(seconds: 8),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
            colors: [Colors.white, myBlue],
            radius: 1.0,
          )),
          child: Stack(
            children: <Widget>[
              backButton(),
              showTextField(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: myBlue,
        child: Icon(Icons.navigate_next),
        onPressed: () {
          formKey.currentState.save();
          print('email = $emailString, password = $passwordString');
          checkAuthen();
        },
      ),
    );
  }
}
