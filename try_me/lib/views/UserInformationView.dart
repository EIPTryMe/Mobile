import 'package:flutter/material.dart';

import 'package:tryme/Globals.dart';
import 'package:tryme/Request.dart';

class UserInformationView extends StatefulWidget {
  @override
  _UserInformationViewState createState() =>
      _UserInformationViewState();
}

String modifyPhoneNumber(String phoneNumber) {
  String tmp = phoneNumber;
  phoneNumber =
      tmp.replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)} ");
  phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
  return (phoneNumber);
}

class _UserInformationViewState extends State<UserInformationView> {
  var edit = new List(7);
  double _widthScreen;
  double _heightScreen;
  bool _infoValid;
  final _formKey = GlobalKey<FormState>();

  String buttonText = 'Sauvegarder';
  String tmp;

  @override
  void initState() {
    initBool(edit);
    super.initState();
  }
  
  void initBool(var list) {
    for (int i = 0; i < 7; i++) {
      list[i] = false;
    }
  }

  Widget _presentation(double widthScreen) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(widthScreen / 20),
          child: CircleAvatar(
            backgroundImage: user.pathToAvatar != null ? NetworkImage(user.pathToAvatar) : AssetImage("assets/company_logo_temp.jpg"),
            radius: widthScreen / 10,
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  //get first name here
                  child: Text(
                    user.firstName != null ? user.firstName : "Pas de prénom défini",
                    style: TextStyle(
                      letterSpacing: 2.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  //get last name here
                  child: Text(
                    user.lastName != null ? user.lastName :  "Pas de nom de famille défini",
                    style: TextStyle(
                      letterSpacing: 2.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _personalFirstName(var edit) {
    if (edit[1]) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                child: Theme(
                  data: ThemeData(
                    primarySwatch: Colors.orange,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Color(0xfff99e38),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue:  user.firstName != null ? user.firstName : "Pas de prénom défini",
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Entrer votre prénom",
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          _infoValid =
                              RegExp(r"^[a-zA-Z-]{2,16}$").hasMatch(value);
                          if (value.isEmpty) {
                            return "Vous n\'avez pas rentré votre prénom";
                          } else if (!_infoValid) {
                            return "Le format de votre prénom est incorrect";
                          }
                          tmp = value;
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    edit[1] = false;
                    edit[0] = false;
                    buttonText = 'Sauvegarder';
                    user.firstName = tmp;
                  }
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                user.firstName != null ? user.firstName : "Pas de prénom défini",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (!edit[0]) {
                    edit[1] = true;
                    edit[0] = true;
                    buttonText = '';
                  }
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _personalLastName(var edit) {
    if (edit[2]) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                child: Theme(
                  data: ThemeData(
                    primarySwatch: Colors.orange,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Color(0xfff99e38),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue: user.lastName != null ? user.lastName : "Pas de nom de famille défini",
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Entrer votre nom de famille",
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          _infoValid =
                              RegExp(r"^[a-zA-Z-' ]{2,20}$").hasMatch(value);
                          if (value.isEmpty) {
                            return "Vous n\'avez pas rentré votre nom de famille";
                          } else if (!_infoValid) {
                            return "Le format de votre nom de famille est incorrect";
                          }
                          tmp = value;
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    edit[2] = false;
                    edit[0] = false;
                    buttonText = 'Sauvegarder';
                    user.lastName = tmp;
                  }
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                user.lastName != null ? user.lastName : "Pas de nom de famille défini",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (!edit[0]) {
                    edit[2] = true;
                    edit[0] = true;
                    buttonText = '';
                  }
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _personalAddress(var edit) {
    if (edit[3]) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                child: Theme(
                  data: ThemeData(
                    primarySwatch: Colors.orange,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Color(0xfff99e38),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue: user.address != null ? user.address : "Pas d'adresse définie",
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Entrer votre adresse",
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          _infoValid = RegExp(r"^[a-zA-Z0-9-', ]{2,100}$")
                              .hasMatch(value);
                          if (value.isEmpty) {
                            return "Vous n\'avez pas rentré votre adresse";
                          } else if (!_infoValid) {
                            return "Le format de votre adresse est incorrect";
                          }
                          tmp = value;
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    edit[3] = false;
                    edit[0] = false;
                    buttonText = 'Sauvegarder';
                    user.address = tmp;
                  }
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                user.address != null ? user.address : "Pas d'adresse définie",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (!edit[0]) {
                    edit[3] = true;
                    edit[0] = true;
                    buttonText = '';
                  }
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _personalPhoneNumber(var edit) {
    if (edit[4]) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                child: Theme(
                  data: ThemeData(
                    primarySwatch: Colors.orange,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Color(0xfff99e38),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue: user.phoneNumber != null ? user.phoneNumber : "Pas de numéro de téléphone défini",
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Entrer votre numéro de téléphone",
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          _infoValid =
                              RegExp(r"^[0-9 ]{10,10}$").hasMatch(value);
                          if (value.isEmpty) {
                            return "Vous n\'avez pas rentré votre numéro de téléphone";
                          } else if (!_infoValid) {
                            return "Le format de votre numéro de téléphone est incorrect";
                          }
                          tmp = value;
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    edit[4] = false;
                    edit[0] = false;
                    buttonText = 'Sauvegarder';
                    tmp = modifyPhoneNumber(tmp);
                    user.phoneNumber = tmp;
                  }
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                user.phoneNumber != null ? user.phoneNumber : "Pas de numéro de téléphone défini",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (!edit[0]) {
                    edit[4] = true;
                    edit[0] = true;
                    buttonText = '';
                  }
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _personalEmail(var edit) {
    if (edit[5]) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                child: Theme(
                  data: ThemeData(
                    primarySwatch: Colors.orange,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Color(0xfff99e38),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue: user.email != null ? user.email : "Pas d'email défini",
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Entre votre email",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          _infoValid = RegExp(
                                  r"^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$")
                              .hasMatch(value);
                          if (value.isEmpty) {
                            return "Vous n\'avez pas rentré votre email";
                          } else if (!_infoValid) {
                            return "Le format de votre email est incorrect";
                          }
                          tmp = value;
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    edit[5] = false;
                    edit[0] = false;
                    buttonText = 'Sauvegarder';
                    user.email = tmp;
                  }
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                user.email != null ? user.email : "Pas d'email défini",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (!edit[0]) {
                    edit[5] = true;
                    edit[0] = true;
                    buttonText = '';
                  }
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _personalBirthDate(var edit) {
    if (edit[6]) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                child: Theme(
                  data: ThemeData(
                    primarySwatch: Colors.orange,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Color(0xfff99e38),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue: user.birthDate != null ? user.birthDate : "Pas de date de naissance définie",
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Entrer votre date de naissance",
                        ),
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          _infoValid = RegExp(
                                  r"^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{4}$")
                              .hasMatch(value);
                          if (value.isEmpty) {
                            return "Vous n\'avez pas rentré votre date de naissance";
                          } else if (!_infoValid) {
                            return "Votre date de naissance est incorrect";
                          }
                          tmp = value;
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    edit[6] = false;
                    edit[0] = false;
                    buttonText = 'Sauvegarder';
                    user.birthDate = tmp;
                  }
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                user.birthDate != null ? user.birthDate : "Pas de date de naissance définie",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (!edit[0]) {
                    edit[6] = true;
                    edit[0] = true;
                    buttonText = '';
                  }
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _myDivider() {
    return Container(
      margin:
          EdgeInsets.only(left: _widthScreen / 10, right: _widthScreen / 10),
      child: Divider(
        height: 1,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    _heightScreen = (_height > _width) ? _height : _width;
    _widthScreen = (_height > _width) ? _width : _height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Informations personnelles'),
        centerTitle: true,
        backgroundColor: Color(0xff1F2C47),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: _heightScreen * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _presentation(_widthScreen),
              _myDivider(),
              _personalFirstName(edit),
              _myDivider(),
              _personalLastName(edit),
              _myDivider(),
              _personalAddress(edit),
              _myDivider(),
              _personalPhoneNumber(edit),
              _myDivider(),
              _personalEmail(edit),
              _myDivider(),
              _personalBirthDate(edit),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    if (!edit[0]) {
                      Request.modifyUser().whenComplete(() => Navigator.pushNamed(context, "home"));
                    }
                  });
                },
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Color(0xff58c24c),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
