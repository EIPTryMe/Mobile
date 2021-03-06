import 'package:flutter/material.dart';

import 'package:tryme/Auth0API.dart';
import 'package:tryme/Globals.dart';
import 'package:tryme/Request.dart';

class CompanySignInView extends StatefulWidget {
  CompanySignInView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CompanySignInViewState createState() => _CompanySignInViewState();
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    var path = Path();

    paint.style = PaintingStyle.fill;
    paint.color = Color(0xff1F2C47);

    path.moveTo(0, size.height * 0.05);
    path.quadraticBezierTo(size.width * 0.08, size.height * 0.33, size.width * 0.32, size.height * 0.20);
    path.quadraticBezierTo(size.width * 0.70, size.height * 0.00, size.width * 1.0, size.height * 0.10);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);

    var paint2 = Paint();
    var path2 = Path();

    paint2.style = PaintingStyle.fill;
    paint2.color = Color(0xff1f2c76);

    path2.moveTo(size.width * 0.02, size.height * 0.03);
    path2.quadraticBezierTo(size.width * 0.08, size.height * 0.21, size.width * 0.32, size.height * 0.12);
    path2.quadraticBezierTo(size.width * 0.70, size.height * 0.00, size.width * 1.0, size.height * 0.06);
    path2.lineTo(size.width, 0);
    path2.lineTo(0, 0);

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _CompanySignInViewState extends State<CompanySignInView> {
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  var _email;
  var _password;
  String error = '';

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.white),
            ),
            Text('Retour', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white))
          ],
        ),
      ),
    );
  }

  Widget _entryFieldEmail(String title) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKeyEmail,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) {
                  return "You didn\'t write your email";
                }
                _email = value;
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _entryFieldPassword(String title) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKeyPassword,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return "You didn't write your password";
                }
                _password = value;
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return FlatButton(
      onPressed: () {
        if (_formKeyEmail.currentState.validate() && _formKeyPassword.currentState.validate()) {
          Auth0API.login(_email, _password).then((isConnected) {
            if (isConnected) {
              Request.getUser().whenComplete(() {
                if (user.companyId != null) {
                  Request.getCompany().whenComplete(() {
                    isLoggedIn = true;
                    isACompany = true;
                    Navigator.pushNamedAndRemoveUntil(context, 'companyHome', ModalRoute.withName('/'));
                  });
                } else {
                  setState(() {
                    error = 'Connectez-vous en tant que client';
                  });
                }
              });
            } else {
              setState(() {
                error = 'Email ou mot de passe invalide';
              });
            }
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
            gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xff1f2c76), Color(0xff1F2C47)])),
        child: Text(
          'Connexion',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'TryMe',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Color(0xffFCA311),
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryFieldEmail("Email Entreprise"),
        _entryFieldPassword("Mot de Passe"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPaint(
      painter: CurvePainter(),
      child: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  _title(),
                  SizedBox(
                    height: 50,
                  ),
                  _emailPasswordWidget(),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  _submitButton(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: Text('Mot de Passe oublié ?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              //  child: _createAccountLabel(),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      )),
    ));
  }
}
