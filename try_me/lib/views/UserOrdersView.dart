import 'package:flutter/material.dart';

import 'package:tryme/widgets/ProductUserOrderCard.dart';
import 'package:tryme/Globals.dart';

class UserOrdersView extends StatefulWidget {
  UserOrdersView({Key key, this.orderStatus}) : super(key: key);
  final String orderStatus;

  @override
  _UserOrdersViewState createState() => _UserOrdersViewState();
}

class _UserOrdersViewState extends State<UserOrdersView> {
  List products = List();
  List productsAll = List();
  List productsOnHold = List();
  List productsExpedited = List();
  List productsDelivered = List();

  ProductOrder product1;

  @override
  void initState() {
    initList(productsAll, 6, "");
    initList(productsOnHold, 1,"En attente");
    initList(productsExpedited, 2, "Expédiée");
    initList(productsDelivered, 3, "Livrée");
    super.initState();
  }

  initList(List products, int n, String status) {
    for (int i = 0; i < n; i++) {
      product1 = ProductOrder();
      product1.name = "Test";
      product1.status = status;
      products.add(product1);
    }
  }

  @override
  Widget build(BuildContext context) {
    String title;
    title = widget.orderStatus;

      switch (title) {
    case 'Mes Commandes':
      products = productsAll;
      break;
    case 'En attente':
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
                    child: ProductUserOrderCard(
                      product: product,
                    ),
                  ))
              .toList(),
        ),
      );
    }
  }
}
