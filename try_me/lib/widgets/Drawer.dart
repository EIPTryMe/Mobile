import 'package:flutter/material.dart';

import 'package:tryme/views/AuthenticationView.dart';
import 'package:tryme/views/CompanySignInView.dart';
import 'package:tryme/views/PersonalInformationView.dart';
import 'package:tryme/Dialogs.dart';
import 'package:tryme/Globals.dart';

class DrawerNotConnected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: 70.0,
          child: DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xfff99e38),
            ),
          ),
        ),
        ListTile(
          title: Text('Authentification'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AuthenticationView()),
            );
          },
        ),
        Divider(
          height: 1,
          color: Colors.grey[800],
        ),
        ListTile(
          title: Text('Entreprise'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CompanySignInView()),
            );
          },
        ),
      ],
    ));
  }
}

class DrawerIsConnected extends StatelessWidget {
  void disconnect(bool _yes) {
    if (_yes) {
      isLoggedIn = false;
      if (isACompany) isACompany = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xfff7892b), Color(0xfffbb448)]),
          ),
          accountName: Text(
            user.firstName != null ? user.firstName : 'Pas de prénom défini',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          accountEmail: Text(user.email != null ? user.email : "Pas d'email défini"),
          currentAccountPicture: CircleAvatar(
            backgroundImage: user.pathToAvatar != null ? NetworkImage(user.pathToAvatar) : AssetImage("assets/company_logo_temp.jpg"),
            //  backgroundImage: AssetImage("assets/company_logo_temp.jpg"),
          ),
        ),
        ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('Informations personnelles'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PersonalInformationView()),
            );
          },
        ),
        Divider(
          height: 1,
          color: Colors.grey[800],
        ),
        ListTile(
          title: Text('Déconnexion'),
          onTap: () async {
            final bool _logout = await LogOut().Confirm(context);
            if (_logout != null) {
              disconnect(_logout);
            }
          },
        ),
      ],
    ));
  }
}
