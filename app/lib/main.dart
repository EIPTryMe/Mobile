import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:app/GraphQLConfiguration.dart';
import 'package:app/pages/HomePage.dart';
import 'package:app/pages/LoginPage.dart';
import 'package:app/pages/SignUpPage.dart';
import 'package:app/pages/ProductPage.dart';
import 'package:app/pages/PersonalInformationsView.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GraphQLProvider(
    child: CacheProvider(
      child: MaterialApp(
        initialRoute: '/personalInformations',
        routes: {
          '/home': (context) => HomePage(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/product': (context) => ProductPage(),
          '/personalInformations': (context) => PersonalInformationsView(),
        },
      ),
    ),
    client: graphQLConfiguration.client,
  ));
}
