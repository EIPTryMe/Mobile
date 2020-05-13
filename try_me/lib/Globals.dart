library my_prj.globals;

import 'package:tryme/GraphQLConfiguration.dart';

class Auth0User {
  String uid = '';
  String accessToken = '';
  String username = '';
  String picture = '';
  String email = '';
  bool isEmailVerified = false;
}

class Company {
  String name = '';
  String email = '';
  String phoneNumber = '';
  String address = '';
  String siret = '';
  String pathToAvatar = '';
}

class User {
  String firstName = '';
  String lastName = '';
  String address = '';
  String phoneNumber = '';
  String email = '';
  String birthDate = '';
  String pathToAvatar = '';
}

class Product {
  int id = 0;
  String name = '';
  int pricePerDay = 0;
  int pricePerWeek = 0;
  int pricePerMonth = 0;
  List descriptions = List();
  List specifications = List();
}

class ProductOrder {
  int id = 0;
  String name = '';
  String status = '';
  int pricePerDay = 0;
  int pricePerWeek = 0;
  int pricePerMonth = 0;
  List descriptions = List();
  List specifications = List();
}

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

bool isLoggedIn = false;
bool isACompany = false;

Auth0User auth0User = Auth0User();
User user = User();
Company company = Company();

Map<int, int> shoppingCard = Map();
