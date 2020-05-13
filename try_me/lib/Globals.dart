library my_prj.globals;

import 'package:tryme/GraphQLConfiguration.dart';

class Auth0User {
  Auth0User({this.uid, this.accessToken, this.username, this.picture, this.email, this.isEmailVerified});

  String uid;
  String accessToken;
  String username;
  String picture;
  String email;
  bool isEmailVerified = false;
}

class Company {
  Company({this.id, this.name, this.email, this.phoneNumber, this.address, this.siret, this.pathToAvatar});

  int id;
  String name;
  String email;
  String phoneNumber;
  String address;
  String siret;
  String pathToAvatar;
}

class User {
  User({this.id, this.firstName, this.lastName, this.address, this.phoneNumber, this.email, this.birthDate, this.pathToAvatar});

  int id;
  String firstName;
  String lastName;
  String address;
  String phoneNumber;
  String email;
  String birthDate;
  String pathToAvatar;
}

class Product {
  Product({this.id, this.name, this.pricePerDay, this.pricePerWeek, this.pricePerMonth, this.descriptions, this.specifications});

  int id;
  String name;
  double pricePerDay;
  double pricePerWeek;
  double pricePerMonth;
  List descriptions;
  List specifications;
}

class Cart {
  Cart({this.product, this.quantity = 1});

  Product product;
  int quantity;
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

List<Cart> shoppingCard = List();
