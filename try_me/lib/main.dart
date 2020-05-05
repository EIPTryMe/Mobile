import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:tryme/views/AuthenticationView.dart';
import 'package:tryme/views/CompanyHomeView.dart';
import 'package:tryme/views/CompanyInformationView.dart';
import 'package:tryme/views/CompanyOrdersView.dart';
import 'package:tryme/views/CompanySignInView.dart';
import 'package:tryme/views/HomeView.dart';
import 'package:tryme/views/PersonalInformationView.dart';
import 'package:tryme/views/ProductView.dart';
import 'package:tryme/views/ShoppingCardView.dart';
import 'package:tryme/views/SignInView.dart';
import 'package:tryme/views/SignUpView.dart';
import 'package:tryme/views/UserOrdersView.dart';
import 'package:tryme/Globals.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
  ));
  runApp(GraphQLProvider(
    child: CacheProvider(
      child: MaterialApp(
        initialRoute: '/home',
        routes: {
          '/home': (context) => HomeView(),
          '/authentication': (context) => AuthenticationView(),
          '/signup': (context) => SignUpView(),
          '/signin': (context) => SignInView(),
          '/shoppingCard': (context) => ShoppingCardView(),
          '/companysignin': (context) => CompanySignInView(),
          '/product': (context) => ProductView(),
          '/personalInformation': (context) => PersonalInformationView(),
          '/companyInformation': (context) => CompanyInformationView(),
          '/companyHome': (context) => CompanyHomeView(),
          '/userOrders': (context) => UserOrdersView(),
          '/companyOrders': (context) => CompanyOrdersView(),
        },
      ),
    ),
    client: graphQLConfiguration.client,
  ));
}
