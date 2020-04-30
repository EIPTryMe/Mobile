library my_prj.globals;

import 'package:tryme/GraphQLConfiguration.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

bool isLoggedIn = false;
bool isACompany = false;

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

Auth0User auth0User = Auth0User();
User user = User();
Company company = Company();
