import 'package:flutter/material.dart';

import 'package:tryme/Globals.dart';
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
  List productsOnHold = List();
  List productsExpedited = List();
  List productsDelivered = List();

  Product product1;

  @override
  void initState() {
    //initList(productsAll, 6, "");
    initList(productsOnHold, 0, "En attente");
    initList(productsExpedited, 0, "Expédiée");
    initList(productsDelivered, 0, "Livrée");
    super.initState();
  }

  initList(List products, int n, String status) {
    for (int i = 0; i < n; i++) {
      product1 = Product();
      product1.name = "Test";
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
        products = productsOnHold;
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
          backgroundColor: Color(0xff1F2C47),
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
          backgroundColor: Color(0xff1F2C47),
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
