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
  Company({this.id, this.name, this.email, this.phoneNumber, this.address, this.siret, this.siren});

  int id;
  String name;
  String email;
  String phoneNumber;
  String address;
  String siret;
  String siren;
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
  int companyId;
}

class Product {
  Product({this.id, this.name, this.brand, this.pricePerDay, this.pricePerWeek, this.pricePerMonth, this.stock, this.description, this.specifications, this.pictures});

  int id;
  String name;
  String brand;
  double pricePerDay;
  double pricePerWeek;
  double pricePerMonth;
  int stock;
  String description;
  List specifications;
  List pictures;
}

class Cart {
  Cart({this.product, this.quantity = 1});

  Product product;
  int quantity;
}

class Order {
  Order({this.id, this.total, this.status, this.products});

  int id;
  double total;
  String status;
  List<Product> products;
}

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

bool isLoggedIn = true;
bool isACompany = true;

Auth0User auth0User = Auth0User();
User user = User();
Company company = Company();

List<Cart> shoppingCard = List();
