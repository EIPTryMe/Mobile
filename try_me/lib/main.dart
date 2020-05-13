import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:tryme/views/AuthentificationView.dart';
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
import 'package:tryme/Router.dart';

/*void tmp() {
  List<Product> products = List();
  Product product1 = Product(name: "Test1", pricePerMonth: 50.0);
  Product product2 = Product(name: "Test2", pricePerMonth: 50.0);
  Product product3 = Product(name: "Test3", pricePerMonth: 50.0);
  Product product4 = Product(name: "Test4", pricePerMonth: 50.0);
  Product product5 = Product(name: "Test5", pricePerMonth: 50.0);
  Product product6 = Product(name: "Test6", pricePerMonth: 50.0);
  shoppingCard[product1] = 1;
  shoppingCard[product2] = 2;
  shoppingCard[product3] = 3;
  shoppingCard[product4] = 4;
  shoppingCard[product5] = 5;
  shoppingCard[product6] = 6;
}*/

void main() {
  //tmp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
  ));
  FluroRouter.setupRouter();
  runApp(GraphQLProvider(
    child: CacheProvider(
      child: MaterialApp(
        initialRoute: 'home',
        onGenerateRoute: FluroRouter.router.generator,
      ),
    ),
    client: graphQLConfiguration.client,
  ));
}
