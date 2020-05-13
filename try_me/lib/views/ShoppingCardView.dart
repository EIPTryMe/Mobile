import 'package:flutter/material.dart';

import 'package:tryme/widgets/ProductShoppingCartCard.dart';
import 'package:tryme/Globals.dart';

class ShoppingCardView extends StatefulWidget {
  @override
  _ShoppingCardViewState createState() => _ShoppingCardViewState();
}

class _ShoppingCardViewState extends State<ShoppingCardView> {
  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Panier'),
        centerTitle: true,
        backgroundColor: Color(0xfff99e38),
      ),
      body: (() {
        if (shoppingCard.isNotEmpty)
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 9,
                child: ListView(
                  children: shoppingCard.map((cart) => ProductShoppingCartCard(cart: cart, callback: callback)).toList(),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Total: €', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: FlatButton(
                        color: Color(0xfff99e38),
                        onPressed: () {},
                        child: Text('Commander', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        else
          return Center(
            child: Text(
              'Votre panier est vide',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          );
      }()),
    );
  }
}
