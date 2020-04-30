import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tryme/GraphQLConfiguration.dart';
import 'package:tryme/views/HomeView.dart';
import 'package:tryme/views/AuthenticationView.dart';
import 'package:tryme/views/SignUpView.dart';
import 'package:tryme/views/SignInView.dart';
import 'package:tryme/views/ProductView.dart';
import 'package:tryme/views/PersonalInformationView.dart';
import 'package:tryme/views/CompanyInformationView.dart';
import 'package:tryme/views/ShoppingCardView.dart';
import 'package:tryme/views/CompanySignInView.dart';
import 'package:tryme/views/CompanyHomeView.dart';

import 'package:tryme/Auth0API.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GraphQLProvider(
    child: CacheProvider(
      child: MaterialApp(
        initialRoute: '/home',
        routes: {
          '/home': (context) => HomeView(),
          '/authentication': (context) => AuthenticationView(),
          '/signup': (context) => SignUpView(),
          '/signin': (context) => SignInView(),
          '/ShoppingBasket': (context) => ShoppingCardView(),
          '/companysignin': (context) => CompanySignInView(),
          '/product': (context) => ProductView(),
          '/personalInformation': (context) => PersonalInformationView(),
          '/companyInformation': (context) => CompanyInformationView(),
          '/companyHome': (context) => CompanyHomeView(),
        },
      ),
    ),
    client: graphQLConfiguration.client,
  ));
}
