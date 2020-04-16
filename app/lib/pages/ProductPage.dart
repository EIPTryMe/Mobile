import 'package:flutter/material.dart';
import 'package:app/widgets/Product.dart';

class ProductPage extends StatefulWidget {
  ProductPage({this.id});

  final int id;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  Map product;

  @override
  void initState()
  {
    super.initState();
    //GetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text(widget.id.toString()),
      ),
    );
  }
}
