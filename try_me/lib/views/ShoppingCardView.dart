import 'package:flutter/material.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:tryme/widgets/ProductShoppingCartCard.dart';
import 'package:tryme/Globals.dart';
import 'package:tryme/Queries.dart';

class ShoppingCardView extends StatefulWidget {
  @override
  _ShoppingCardViewState createState() => _ShoppingCardViewState();
}

class _ShoppingCardViewState extends State<ShoppingCardView> {
  List<Product> products = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Panier'),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      body: ListView(
        children: shoppingCard.entries
            .map((it) => ProductShoppingCartCard(
                  id: it.key,
                ))
            .toList(),
      ),
    );
  }
}
