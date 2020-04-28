import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth0/flutter_auth0.dart';

String domain = 'dev-2o6a8byc.eu.auth0.com/api/v2';
String clientId = 'YIfBoxMsxuVG6iTGNlxX3g7lvecyzrVQ';

class LoginTest extends StatefulWidget {
  @override
  _LoginTestState createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> {
  Auth0 auth0;
  bool webLogged = false;
  Map currentWebAuth;

  @override
  void initState() {
    auth0 = Auth0(baseUrl: 'https://$domain/', clientId: clientId);

    super.initState();
  }

  void showInfo(String str) {
    print(str);
  }

  void register() async {
    try {
      var response =
          await auth0.auth.createUser({'email': 'oui@auth0.com', 'password': '&Azerty1234', 'connection': 'Username-Password-Authentication'});
      showInfo('''
    \nid: ${response['_id']}
    \nusername/email: ${response['email']}
    ''');
    } catch (e) {
      print(e);
    }
  }

  void login() async {
    try {
      var response =
          await auth0.auth.passwordRealm({'username': 'oui@auth0.com', 'password': '&Azerty1234', 'realm': 'Username-Password-Authentication'});
      showInfo('''
    \nAccess Token: ${response['access_token']}
    ''');
    } catch (e) {
      print(e);
    }
  }

  void webAuth() async {
    try {
      var response = await auth0.webAuth.authorize({
        'audience': 'https://$domain/userinfo',
        'scope': 'openid email offline_access',
      });
      DateTime now = DateTime.now();
      showInfo('''
    \ntoken_type: ${response['token_type']}
    \nexpires_in: ${DateTime.fromMillisecondsSinceEpoch(response['expires_in'] + now.millisecondsSinceEpoch)}
    \nrefreshToken: ${response['refresh_token']}
    \naccess_token: ${response['access_token']}
    ''');
      webLogged = true;
      currentWebAuth = Map.from(response);
      setState(() {});
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlatButton(
              color: Colors.orange,
              onPressed: () => this.login(),
              child: Text("Login"),
            ),
            FlatButton(
              color: Colors.orange,
              onPressed: () => this.register(),
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
