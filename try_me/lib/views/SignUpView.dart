import 'package:flutter/material.dart';
import 'package:tryme/views/SignInView.dart';
import 'package:tryme/Auth0API.dart';
import 'package:tryme/Globals.dart' as globals;

class SignUpView extends StatefulWidget {
  SignUpView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    var path = Path();

    paint.style = PaintingStyle.fill;
    paint.color = Color(0xfff7892b);

    path.moveTo(0, size.height * 0.05);
    path.quadraticBezierTo(size.width * 0.08, size.height * 0.33, size.width * 0.32, size.height * 0.20);
    path.quadraticBezierTo(size.width * 0.70, size.height * 0.00, size.width * 1.0, size.height * 0.10);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);

    var paint2 = Paint();
    var path2 = Path();

    paint2.style = PaintingStyle.fill;
    paint2.color = Color(0xfffbb448);

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

class _SignUpViewState extends State<SignUpView> {
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  final _formKeyConfirm = GlobalKey<FormState>();
  var _email;
  var _password;

  bool _emailValid;
  bool _passwordValid;
  var _firstPassword;

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
              child: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.black,
              ),
            ),
            Text('Retour', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryFieldEmail(String title) {
    return Container(
      padding: const EdgeInsets.all(5.0),
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
                _emailValid = RegExp(r"^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$").hasMatch(value);
                if (value.isEmpty) {
                  return "You didn\'t write your email";
                } else if (!_emailValid) {
                  return "Your email address is incorrect";
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
      padding: const EdgeInsets.all(5.0),
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
                _passwordValid = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,20})").hasMatch(value);
                if (value.isEmpty) {
                  return "You didn't write your password";
                } else if (!_passwordValid) {
                  return "Your password is incorrect";
                }
                _firstPassword = value;
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _entryFieldConfirm(String title) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Form(
        key: _formKeyConfirm,
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
                  return "You didn't confirm your password";
                } else if (value != _firstPassword) {
                  return "Your passwords do not match";
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
        if (_formKeyEmail.currentState.validate() && _formKeyPassword.currentState.validate() && _formKeyConfirm.currentState.validate()) {
          Auth0API.register(_email, _password).then((isConnected) {
            if (isConnected) {
              globals.isLoggedIn = true;
              globals.isACompany = false;
              Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/'));
            }
          });
          print(_email);
          print(_password);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
            gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          "S\'inscrire maintenant",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _facebookButton() {
    return FlatButton(
      onPressed: () {},
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1959a9),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage('assets/facebook_Logo.png'),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff2872ba),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text('S\'inscrire avec Facebook', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _googleButton() {
    return FlatButton(
      onPressed: () {},
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffffff),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage('assets/google_Logo.jpg'),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffff3d00),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text('S\'inscrire avec Google', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Vous avez déjà un compte ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignInView()));
            },
            child: Text(
              'Connectez-vous ici',
              style: TextStyle(color: Color(0xfff79c4f), fontSize: 13, fontWeight: FontWeight.w600),
            ),
          )
        ],
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
          color: Color(0xffe46b10),
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryFieldEmail("Email"),
        _entryFieldPassword("Mot de Passe"),
        _entryFieldConfirm("Confirmer mot de passe"),
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
                    flex: 3,
                    child: SizedBox(),
                  ),
                  _title(),
                  SizedBox(
                    height: 50,
                  ),
                  _emailPasswordWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  _submitButton(),
                  _facebookButton(),
                  _googleButton(),
                  Expanded(
                    flex: 2,
                    child: SizedBox(),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _loginAccountLabel(),
            ),
            Positioned(top: 40, left: 10, child: _backButton()),
          ],
        ),
      )),
    ));
  }
}
