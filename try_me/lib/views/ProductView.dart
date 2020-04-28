import 'package:flutter/material.dart';

class ProductView extends StatefulWidget {
  ProductView({this.id});

  final int id;

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {

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
