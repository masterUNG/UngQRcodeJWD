import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  String nameLogin = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Method
  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Future<void> findDisplayName() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      nameLogin = firebaseUser.displayName;
    });
  }

  Widget showLogin() {
    return Text('Login by $nameLogin');
  }

  Widget showAppName() {
    return Text(
      'Ung QR code',
      style: TextStyle(
          fontSize: 18.0, color: Colors.purple, fontFamily: 'IndieFlower'),
    );
  }

  Widget showLogo() {
    return Container(
      height: 80.0,
      width: 80.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget myDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.white, Colors.yellow],
          radius: 1.0,
        ),
      ),
      child: Column(
        children: <Widget>[
          showLogo(),
          showAppName(),
          showLogin(),
        ],
      ),
    );
  }

  Widget myDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          myDrawerHeader(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      body: Text('body'),
      drawer: myDrawer(),
    );
  }
}
