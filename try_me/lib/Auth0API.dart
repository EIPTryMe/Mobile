import 'package:flutter_auth0/flutter_auth0.dart';

import 'package:tryme/Globals.dart' as global;

class Auth0API {
  static String domain = 'dev-2o6a8byc.eu.auth0.com';
  static String clientId = 'YIfBoxMsxuVG6iTGNlxX3g7lvecyzrVQ';
  static Auth0 auth0 = Auth0(baseUrl: 'https://$domain/', clientId: clientId);

  static Future<bool> register(String email, String password) async {
    try {
      var response = await auth0.auth.createUser({'email': email, 'password': password, 'connection': 'Username-Password-Authentication'});

      print('''
    \nid: ${response['_id']}
    \nusername/email: ${response['email']}
    ''');
      return (await login(email, password));
    } catch (e) {
      print(e);
      return (false);
    }
  }

  static Future<bool> login(String email, String password) async {
    global.shoppingCard.clear();
    global.auth0User = global.Auth0User();
    global.user = global.User();
    global.company = global.Company();
    try {
      var response = await auth0.auth.passwordRealm({'username': email, 'password': password, 'realm': 'Username-Password-Authentication'});

      global.auth0User.accessToken = response['access_token'];

      print('''
    \nAccess Token: ${response['access_token']}
    ''');

      return (await userInfo());
    } catch (e) {
      print(e);
      return (false);
    }
  }

  static void webAuth() async {
    try {
      var response = await auth0.webAuth.authorize({
        'audience': 'https://$domain/userinfo',
        'scope': 'openid email offline_access',
      });
      DateTime now = DateTime.now();
      print('''
    \ntoken_type: ${response['token_type']}
    \nexpires_in: ${DateTime.fromMillisecondsSinceEpoch(response['expires_in'] + now.millisecondsSinceEpoch)}
    \nrefreshToken: ${response['refresh_token']}
    \naccess_token: ${response['access_token']}
    ''');
      //webLogged = true;
      //currentWebAuth = Map.from(response);
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<bool> userInfo() async {
    try {
      var authClient = Auth0Auth(auth0.auth.clientId, auth0.auth.client.baseUrl, bearer: global.auth0User.accessToken);
      var info = await authClient.getUserInfo();

      global.auth0User.uid = info['sub'];
      global.auth0User.username = info['nickname'];
      global.auth0User.picture = info['picture'];
      global.auth0User.email = info['email'];
      global.auth0User.isEmailVerified = info['email_verified'];

      String buffer = '';
      info.forEach((k, v) => buffer = '$buffer\n$k: $v');
      print(buffer);

      return (true);
    } catch (e) {
      print(e);
      return (false);
    }
  }
}
