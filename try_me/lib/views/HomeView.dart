import 'package:flutter/material.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:tryme/Globals.dart';
import 'package:tryme/Queries.dart';
import 'package:tryme/widgets/AppBar.dart';
import 'package:tryme/widgets/Drawer.dart';
import 'package:tryme/widgets/ProductCard.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Product> products = List();

  void getData() async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(documentNode: gql(Queries.products()));
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
    if (this.mounted)
      setState(() {
        products.clear();
        (result.data['product'] as List).forEach((element) {
          Product product = Product();
          product.id = element['id'];
          product.name = element['name'];
          product.pricePerDay = element['price_per_day'];
          product.pricePerWeek = element['price_per_week'];
          product.pricePerMonth = element['price_per_month'];
          product.descriptions = element['product_descriptions'];
          product.specifications = element['product_specifications'];
          products.add(product);
        });
      });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (!isACompany) {
      return Scaffold(
        appBar: MyAppBar(),
        drawer: isLoggedIn ? DrawerIsConnected() : DrawerNotConnected(),
        body: ListView(
          children: products
              .map((product) => Padding(
                    padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                    child: ProductCard(
                      product: product,
                    ),
                  ))
              .toList(),
        ),
        backgroundColor: Colors.grey[200],
      );
    }
  }
}
