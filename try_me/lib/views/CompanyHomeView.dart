import 'package:flutter/material.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:tryme/widgets/AppBar.dart';
import 'package:tryme/widgets/Drawer.dart';
import 'package:tryme/widgets/ProductCard.dart';
import 'package:tryme/Globals.dart';
import 'package:tryme/Queries.dart';

class CompanyHomeView extends StatefulWidget {
  @override
  _CompanyHomeViewState createState() => _CompanyHomeViewState();
}

class _CompanyHomeViewState extends State<CompanyHomeView> {
  List<Product> products = List();

  void getData() async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(documentNode: gql(Queries.productsCompany(company.id)));
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
    if (this.mounted)
      setState(() {
        products.clear();
        (result.data['company'][0]['products'] as List).forEach((element) {
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
      drawer: DrawerCompany(),
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
