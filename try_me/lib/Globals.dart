library my_prj.globals;

bool isLoggedIn = false;
bool isACompany = false;

class User {
  String uid = '';
  String accessToken = '';
  String username = '';
  String picture = '';
  String email = '';
  bool isEmailVerified = false;
}

User user = User();
