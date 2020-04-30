library my_prj.globals;

bool isLoggedIn = false;
bool isACompany = false;

class Company {
  String name;
  String email;
  String phoneNumber;
  String address;
  String siret;
  String pathToAvatar;
}

Company myCompany;

void initCompany(Company myCompany) {
  myCompany.name = "test";
  myCompany.email = "testcompany@test.com";
  myCompany.phoneNumber = "06 28 82 25 45";
  myCompany.address = "123 rue du test, ville de test";
  myCompany.siret = "802 954 785 00028";
  myCompany.pathToAvatar = "assets/company_logo_temp.jpg";
}