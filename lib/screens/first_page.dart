import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ung_qr_code/models/product_model.dart';
import 'package:ung_qr_code/screens/detail.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  // Explicit
  Firestore fireStore = Firestore.instance;
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshots;
  List<ProductModel> productModels = [];

  // Method
  @override
  void initState() {
    super.initState();
    readFireStore();
  }

  Future<void> readFireStore() async {
    CollectionReference collectionReference = fireStore.collection('Produce');
    subscription = await collectionReference.snapshots().listen((dataSnapshot) {
      snapshots = dataSnapshot.documents;

      for (var snapshot in snapshots) {
        String name = snapshot.data['Name'];
        String detail = snapshot.data['Detail'];
        String picture = snapshot.data['Image'];
        print('name = $name');

        ProductModel productModel = ProductModel(name, detail, picture);

        setState(() {
          productModels.add(productModel);
        });
      }
    });
  }

  Widget showPicture(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Image.network(productModels[index].picture),
    );
  }

  Widget showText(int index) {
    return Column(
      children: <Widget>[
        Text(productModels[index].name),
        Text(
          productModels[index].detail,
        )
      ],
    );
  }

  Widget showListView() {
    return ListView.builder(
      itemCount: productModels.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Row(
            children: <Widget>[
              showPicture(index),
              showText(index),
            ],
          ),
          onTap: () {
            MaterialPageRoute materialPageRoute = MaterialPageRoute(
                builder: (BuildContext context) => Detail(
                      productModel: productModels[index],
                    ));
                    Navigator.of(context).push(materialPageRoute);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return showListView();
  }
}
