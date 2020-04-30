library my_prj.globals;

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

Auth0User auth0User = Auth0User();

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

Company myCompany = Company();
