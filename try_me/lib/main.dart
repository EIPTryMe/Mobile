import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tryme/GraphQLConfiguration.dart';
import 'package:tryme/views/HomeView.dart';
import 'package:tryme/views/AuthenticationView.dart';
import 'package:tryme/views/SignUpView.dart';
import 'package:tryme/views/SignInView.dart';
import 'package:tryme/views/ProductView.dart';
import 'package:tryme/views/PersonalInformationView.dart';
import 'package:tryme/views/ShoppingBasketView.dart';

import 'package:tryme/LoginTest.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GraphQLProvider(
    child: CacheProvider(
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/test': (context) => LoginTest(),
          '/': (context) => HomeView(),
          '/authentication': (context) => AuthenticationView(),
          '/signup': (context) => SignUpView(),
          '/signin': (context) => SignInView(),
          '/ShoppingBasket': (context) => ShoppingBasketView(),
          '/personalInformation': (context) => PersonalInformationView(),
        },
      ),
    ),
    client: graphQLConfiguration.client,
  ));
}
