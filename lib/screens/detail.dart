import 'package:flutter/material.dart';
import 'package:ung_qr_code/models/product_model.dart';

class Detail extends StatefulWidget {
  final ProductModel productModel;
  Detail({Key key, this.productModel}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  // Explicit
  ProductModel myProductModel;

  // Method
  @override
  void initState() {
    super.initState();
    myProductModel = widget.productModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Column(
        children: <Widget>[
          Text(myProductModel.name),
          Image.network(myProductModel.picture),
          Text(myProductModel.detail)
        ],
      ),
    );
  }
}
