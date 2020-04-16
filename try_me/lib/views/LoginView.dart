import 'package:flutter/material.dart';
import 'package:tryme/views/HomeView.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool _emailValid;
  bool _passwordValid;
  var _firstPassword;

  @override
  Widget build(BuildContext context) {
    double _heightScreen =  MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: _heightScreen/18),
                Image(
                  image: NetworkImage('https://unlimitedrone.com/wp-content/uploads/2016/07/insert-logo-here.png'),
                ),
                SizedBox(height: _heightScreen/25),
                Form(
                    child: Theme(
                      data: ThemeData(
                        brightness: Brightness.dark,
                        primarySwatch: Colors.teal,
                        inputDecorationTheme: InputDecorationTheme(
                            labelStyle: TextStyle(
                              color: Colors.teal,
                              fontSize: 10.0,
                            )),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(40.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Enter Email",
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  _emailValid = RegExp(
                                      r"^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$")
                                      .hasMatch(value);
                                  if (value.isEmpty) {
                                    return "You didn\'t write your email";
                                  } else if (!_emailValid) {
                                    return "Your email address is incorrect";
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Enter Password",
                                ),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                validator: (value) {
                                  _passwordValid = RegExp(
                                      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,20})")
                                      .hasMatch(value);
                                  if (value.isEmpty) {
                                    return "You didn't write your password";
                                  }
                                  else if (!_passwordValid) {
                                    return  "Your password is incorrect";
                                  }
                                  _firstPassword = value;
                                  return null;
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Confirm Password",
                                ),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "You didn't confirm your password";
                                  }
                                  else if (value != _firstPassword) {
                                    return "Your passwords do not match";
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 40.0),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeView()),
                                    );
                                  }
                                },
                                height: 40.0,
                                minWidth: 60.0,
                                color: Colors.teal,
                                textColor: Colors.white,
                                child: Text('Login'),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
