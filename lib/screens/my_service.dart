import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ung_qr_code/screens/first_page.dart';
import 'package:ung_qr_code/screens/home.dart';
import 'package:ung_qr_code/screens/second_page.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  String nameLogin = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Widget myWidget = FirstPage();

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
    return Text(
      'Login by $nameLogin',
      style: TextStyle(color: Colors.white),
    );
  }

  Widget showAppName() {
    return Text(
      'Ung QR code',
      style: TextStyle(
          fontSize: 18.0, color: Colors.white, fontFamily: 'IndieFlower'),
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
        image: DecorationImage(
            image: AssetImage('images/land.jpg'), fit: BoxFit.fill),
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

  Widget pageFirstMenu() {
    return ListTile(
      leading: Icon(Icons.home),
      title: Text('First Page'),
      subtitle: Text('นี่คือหน้าแสดง ListView'),
      onTap: () {
        setState(() {
          myWidget = FirstPage();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget pageSecondMenu() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('Second Page'),
      onTap: () {
        setState(() {
          myWidget = SecondPage();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget pageSignOutMenu() {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Sign Out'),
      onTap: () {
        Navigator.of(context).pop();
        mySignOut();
      },
    );
  }

  Future<void> mySignOut() async {
    await firebaseAuth.signOut().then(
      (response) {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Home());
        Navigator.of(context).pushAndRemoveUntil(
            materialPageRoute, (Route<dynamic> route) => false);
      },
    );
  }

  Widget myDivider() {
    return Divider();
  }

  Widget myDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          myDrawerHeader(),
          pageFirstMenu(),
          myDivider(),
          pageSecondMenu(),
          myDivider(),
          pageSignOutMenu(),
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
      body: myWidget,
      drawer: myDrawer(),
    );
  }
}
