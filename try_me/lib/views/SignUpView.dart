import 'package:flutter/material.dart';

import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

import 'package:tryme/Auth0API.dart';
import 'package:tryme/Globals.dart';
import 'package:tryme/Request.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  final _formKeyConfirmPassword = GlobalKey<FormState>();
  var _email;
  var _password;
  var _confirmPassword;
  String error = '';

  Widget _entryFieldEmail(String title) {
    return Container(
      child: Form(
        key: _formKeyEmail,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xff1f2c76), width: 2.0)),
            labelText: title,
          ),
          validator: (value) {
            if (value.isEmpty) {
              return "Vous n\'avez pas rentré votre email";
            }
            _email = value;
            return null;
          },
        ),
      ),
    );
  }

  Widget _entryFieldPassword(String title) {
    return Container(
      child: Form(
        key: _formKeyPassword,
        child: TextFormField(
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xff1f2c76), width: 2.0)),
            labelText: title,
          ),
          keyboardType: TextInputType.text,
          obscureText: true,
          validator: (value) {
            bool passwordIsValid = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,20})").hasMatch(value);
            if (value.isEmpty) {
              return "Vous n\'avez pas rentré votre mot de passe";
            } else if (!passwordIsValid) {
              return "Le format de votre mot de passe est incorrect";
            }
            _password = value;
            return null;
          },
        ),
      ),
    );
  }

  Widget _entryFieldConfirmPassword(String title) {
    return Container(
      child: Form(
        key: _formKeyConfirmPassword,
        child: TextFormField(
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xff1f2c76), width: 2.0)),
            labelText: title,
          ),
          keyboardType: TextInputType.text,
          obscureText: true,
          validator: (value) {
            _confirmPassword = value;
            if (value.isEmpty) {
              return "Vous n\'avez pas confirmé votre mot de passe";
            } else if (_password != _confirmPassword) {
              return "Vos mots de passe ne correspondent pas";
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Déjà inscrit ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'signIn');
            },
            child: Text(
              'Connectez-vous',
              style: TextStyle(color: Color(0xffFCA311), fontSize: 13, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return ButtonTheme(
      height: 50.0,
      child: RaisedButton(
        onPressed: () {
          if (_formKeyEmail.currentState.validate() && _formKeyPassword.currentState.validate() && _formKeyConfirmPassword.currentState.validate()) {
            Auth0API.register(_email, _password).then((isConnected) {
              if (isConnected) {
                Request.getUser().whenComplete(() {
                  isLoggedIn = true;
                  isACompany = false;
                  //Navigator.pushNamedAndRemoveUntil(context, 'personalInformationAfterInscription', ModalRoute.withName('/'));
                  Navigator.popUntil(context, ModalRoute.withName('home'));
                  Navigator.pushNamed(context, 'personalInformationAfterInscription');
                });
              }
            });
          }
        },
        color: Color(0xffFCA311),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Text(
          "S'inscrire",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        padding: const EdgeInsets.all(0.0),
      ),
    );
  }

  Widget _iDPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryFieldEmail("Email"),
        SizedBox(height: 20.0),
        _entryFieldPassword("Mot de Passe"),
        SizedBox(height: 20.0),
        _entryFieldConfirmPassword("Confirmer Mot de Passe"),
      ],
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      child: FacebookSignInButton(
        text: "Se connecter avec Facebook",
        onPressed: () {
          Auth0API.webAuth(SocialAuth_e.FACEBOOK).then((isConnected) {
            if (isConnected) {
              Request.getUser().whenComplete(() {
                Request.getShoppingCard();
                isLoggedIn = true;
                isACompany = false;
                Navigator.pushNamedAndRemoveUntil(context, 'home', ModalRoute.withName('/'));
              });
            }
          });
        },
      ),
    );
  }

  Widget _googleButton() {
    return Container(
      height: 50,
      child: GoogleSignInButton(
        text: "Se connecter avec Google",
        onPressed: () {
          Auth0API.webAuth(SocialAuth_e.GOOGLE).then((isConnected) {
            if (isConnected) {
              Request.getUser().whenComplete(() {
                Request.getShoppingCard();
                isLoggedIn = true;
                isACompany = false;
                Navigator.pushNamedAndRemoveUntil(context, 'home', ModalRoute.withName('/'));
              });
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _iDPasswordWidget(),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    _submitButton(),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _facebookButton(),
                    Divider(),
                    _googleButton(),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _createAccountLabel(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
