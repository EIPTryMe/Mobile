import 'package:flutter/material.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:tryme/GraphQLConfiguration.dart';
import 'package:tryme/Request.dart';

import 'package:tryme/widgets/AppBar.dart';
import 'package:tryme/widgets/Drawer.dart';
import 'package:tryme/widgets/Filter.dart';
import 'package:tryme/widgets/ProductCard.dart';
import 'package:tryme/Globals.dart';
import 'package:tryme/Queries.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Product> products = List();

  void callback(String option) {
    getData(option);
  }

  void getData([String option]) async {
    QueryResult result;
    String query;
    if (option == 'Nom A-Z' || option == null)
      query = Queries.productsName(true);
    else if (option == 'Nom Z-A')
      query = Queries.productsName(false);
    else if (option == 'Prix croissant')
      query = Queries.productsPrice(true);
    else if (option == 'Prix décroissant') query = Queries.productsPrice(false);
    QueryOptions queryOption = QueryOptions(documentNode: gql(query));
    graphQLConfiguration = GraphQLConfiguration();
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
    if (this.mounted)
      setState(() {
        products.clear();
        (result.data['product'] as List).forEach((element) {
          products.add(QueryParse.getProductHome(element));
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
    return Scaffold(
      appBar: MyAppBar(),
      drawer: isLoggedIn ? DrawerIsConnected() : DrawerNotConnected(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Filter(callback),
          ),
          Expanded(
            flex: 15,
            child: ListView(
              children: products
                  .map((product) =>
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                    child: ProductCard(
                      product: product,
                    ),
                  ))
                  .toList(),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
