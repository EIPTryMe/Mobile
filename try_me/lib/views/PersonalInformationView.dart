import 'package:flutter/material.dart';
import 'package:tryme/Globals.dart' as globals;

class PersonalInformationView extends StatefulWidget {
  @override
  _PersonalInformationViewState createState() =>
      _PersonalInformationViewState();
}

class UserInfo {
  String firstName;
  String lastName;
  String address;
  String phoneNumber;
  String email;
  String birthDate;
}

String modifyPhoneNumber(String phoneNumber) {
  String tmp = phoneNumber;
  phoneNumber =
      tmp.replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)} ");
  phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
  return (phoneNumber);
}

class _PersonalInformationViewState extends State<PersonalInformationView> {
  var edit = new List(7);
  double _widthScreen;
  double _heightScreen;
  bool _infoValid;
  var user = new UserInfo();
  final _formKey = GlobalKey<FormState>();

  String buttonText = 'Save';
  String tmp;

  @override
  void initState() {
    initBool(edit);
    getInfoUser();
    super.initState();
  }

  //Cette fonction fera les appels en bdd pour remplir la classe UserInfo

  void getInfoUser() {
    user.firstName = 'Auguste';
    user.lastName = 'Larrive Jahan';
    user.address = '15 Chemin du clot, 0500, Romette';
    user.phoneNumber = '06 28 82 25 45';
    user.email = 'augustelarrivejahan@gmail.com';
    user.birthDate = '10/10/1997';
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
            backgroundImage: AssetImage('assets/company_logo_temp.jpg'),
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
                    user.firstName,
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
                    user.lastName,
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
                        initialValue: globals.auth0User.username,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Enter First Name",
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          _infoValid =
                              RegExp(r"^[a-zA-Z-]{2,16}$").hasMatch(value);
                          if (value.isEmpty) {
                            return "You didn\'t write your first name";
                          } else if (!_infoValid) {
                            return "Your first name is incorrect";
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
                    buttonText = 'Save';
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
                user.firstName,
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
                        initialValue: user.lastName,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Enter Last Name",
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          _infoValid =
                              RegExp(r"^[a-zA-Z-' ]{2,20}$").hasMatch(value);
                          if (value.isEmpty) {
                            return "You didn\'t write your last name";
                          } else if (!_infoValid) {
                            return "Your last name is incorrect";
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
                    buttonText = 'Save';
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
                user.lastName,
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
                        initialValue: user.address,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Enter Address",
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          _infoValid = RegExp(r"^[a-zA-Z0-9-', ]{2,100}$")
                              .hasMatch(value);
                          if (value.isEmpty) {
                            return "You didn\'t write your address";
                          } else if (!_infoValid) {
                            return "Your address is incorrect";
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
                    buttonText = 'Save';
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
                user.address,
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
                        initialValue: user.phoneNumber,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Enter Phone Number",
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          _infoValid =
                              RegExp(r"^[0-9 ]{10,10}$").hasMatch(value);
                          if (value.isEmpty) {
                            return "You didn\'t write your phone number";
                          } else if (!_infoValid) {
                            return "Your phone number is incorrect";
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
                    buttonText = 'Save';
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
                user.phoneNumber,
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
                        initialValue: user.email,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Enter Email",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          _infoValid = RegExp(
                                  r"^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$")
                              .hasMatch(value);
                          if (value.isEmpty) {
                            return "You didn\'t write your email";
                          } else if (!_infoValid) {
                            return "Your email is incorrect";
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
                    buttonText = 'Save';
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
                user.email,
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
                        initialValue: user.birthDate,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Enter BirthDate",
                        ),
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          _infoValid = RegExp(
                                  r"^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{4}$")
                              .hasMatch(value);
                          if (value.isEmpty) {
                            return "You didn\'t write your birth date";
                          } else if (!_infoValid) {
                            return "Your birth date is incorrect";
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
                    buttonText = 'Save';
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
                user.birthDate,
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
        backgroundColor: Color(0xfff99e38),
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
                      //fonction de sauvegarde en bdd + quitter la View
                      print('Save and quit');
                    }
                  });
                },
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Color(0xfff99e38),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
