import 'package:flutter/material.dart';

import 'package:tryme/widgets/ProductCard.dart';

class CompanyOrdersView extends StatefulWidget {
  CompanyOrdersView({Key key, this.orderStatus}) : super(key: key);
  final String orderStatus;


  @override
  _CompanyOrdersViewState createState() => _CompanyOrdersViewState();
}

class _CompanyOrdersViewState extends State<CompanyOrdersView> {
  List products = List();
  List productsAll = List();
  List productsInProgress = List();
  List productsExpedited = List();
  List productsDelivered = List();

  //Product product1;
  var product1 = {
    'name': 'tom',
    'image': 'https://i.redd.it/ugaauduw5ks31.png'
  };

  @override
  void initState() {
    initList(productsAll, 6);
    initList(productsInProgress, 1);
    initList(productsExpedited, 2);
    initList(productsDelivered, 3);
    super.initState();
  }

  initList(List products, int n) {
    for (int i = 0; i < n; i++) {
      products.add(product1);
    }
  }

  @override
  Widget build(BuildContext context) {
    String title;
    title = widget.orderStatus;

    switch (title) {
      case 'Toutes vos commandes':
        products = productsAll;
        break;
      case 'En cours':
        products = productsInProgress;
        break;
      case 'Expédiées':
        products = productsExpedited;
        break;
      case 'Livrées':
        products = productsDelivered;
        break;
    }

    if (products.length == 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          backgroundColor: Color(0xfff99e38),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.assignment,
                size: 100.0,
                color: Colors.grey,
              ),
              Text(
                'Vous n\'avez pas de commandes',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          backgroundColor: Color(0xfff99e38),
        ),
        body: ListView(
          children: products
              .map((product) => Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: ProductCard(
              product: product,
            ),
          ))
              .toList(),
        ),
      );
    }
  }
}
