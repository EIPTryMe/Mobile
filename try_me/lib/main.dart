import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tryme/GraphQLConfiguration.dart';
import 'package:tryme/views/HomeView.dart';
import 'package:tryme/views/LoginView.dart';
import 'package:tryme/views/RegisterView.dart';
import 'package:tryme/views/PersonalInformationView.dart';

import 'package:tryme/LoginTest.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GraphQLProvider(
    child: CacheProvider(
      child: MaterialApp(
        initialRoute: '/test',
        routes: {
          '/test': (context) => LoginTest(),
          '/': (context) => HomeView(),
          '/login': (context) => LoginView(),
          '/register': (context) => RegisterView(),
          '/personalInformation': (context) => PersonalInformationView(),
        },
      ),
    ),
    client: graphQLConfiguration.client,
  ));
}
