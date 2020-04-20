import 'package:flutter/material.dart';

class ShoppingBasketView extends StatefulWidget {
  @override
  _ShoppingBasketViewState createState() => _ShoppingBasketViewState();
}

class _ShoppingBasketViewState extends State<ShoppingBasketView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Panier'),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
    );
  }
}
