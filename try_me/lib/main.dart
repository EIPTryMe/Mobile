import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tryme/GraphQLConfiguration.dart';
import 'package:tryme/views/HomeView.dart';
import 'package:tryme/views/AuthenticationView.dart';
import 'package:tryme/views/SignUpView.dart';
import 'package:tryme/views/SignInView.dart';
import 'package:tryme/views/RegisterView.dart';
import 'package:tryme/views/ProductView.dart';
import 'package:tryme/views/PersonalInformationView.dart';
import 'package:tryme/views/ShoppingBasketView.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GraphQLProvider(
    child: CacheProvider(
      child: MaterialApp(
        //initialRoute: '/',
        routes: {
          '/': (context) => HomeView(),
          '/authentication': (context) => AuthenticationView(),
          '/signup': (context) => SignUpView(),
          '/signin': (context) => SignInView(),
          '/register': (context) => RegisterView(),
          '/product': (context) => ProductView(),
          '/personalInformations': (context) => PersonalInformationView(),
          '/ShoppingBasket' : (context) => ShoppingBasketView(),
        },
      ),
    ),
    client: graphQLConfiguration.client,
  ));
}
