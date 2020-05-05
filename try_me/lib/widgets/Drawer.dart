import 'package:flutter/material.dart';

import 'package:tryme/views/AuthenticationView.dart';
import 'package:tryme/views/CompanyInformationView.dart';
import 'package:tryme/views/CompanyOrdersView.dart';
import 'package:tryme/views/CompanySignInView.dart';
import 'package:tryme/views/PersonalInformationView.dart';
import 'package:tryme/views/UserOrdersView.dart';
import 'package:tryme/Dialogs.dart';
import 'package:tryme/Globals.dart';

void disconnect(bool _yes, BuildContext context) {
  if (_yes) {
    isLoggedIn = false;
    if (isACompany) isACompany = false;
    Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/'));
  }
}

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
          ),
        ),
        ListTile(
          leading: Icon(Icons.assignment),
          title: Text(
            'Mes Commandes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserOrdersView(
                            orderStatus: 'Mes Commandes',
                          )),
                );
              },
              child: Text(
                'Tout voir',
                style: TextStyle(
                  color: Color(0xff3e97b7),
                  fontSize: 12.0,
                ),
              )),
        ),
        Column(
          children: <Widget>[
            ListTile(
              title: Text(
                'En attente',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserOrdersView(
                            orderStatus: 'En attente',
                          )),
                );
              },
            ),
            ListTile(
              title: Text(
                'Expédiées',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserOrdersView(
                            orderStatus: 'Expédiées',
                          )),
                );
              },
            ),
            ListTile(
              title: Text(
                'Livrées',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserOrdersView(
                            orderStatus: 'Livrées',
                          )),
                );
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: Divider(
            height: 1,
            color: Colors.grey[800],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: Divider(
            height: 1,
            color: Colors.grey[800],
          ),
        ),
        ListTile(
          leading: Icon(Icons.info_outline),
          title: Text(
            'Informations personnelles',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PersonalInformationView()),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: Divider(
            height: 1,
            color: Colors.grey[800],
          ),
        ),
        ListTile(
          title: Text(
            'Déconnexion',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () async {
            final bool _logout = await LogOut().confirm(context);
            if (_logout != null) {
              disconnect(_logout, context);
            }
          },
        ),
      ],
    ));
  }
}

class DrawerCompany extends StatelessWidget {
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
            company.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          accountEmail: Text(company.email),
          currentAccountPicture: CircleAvatar(
            backgroundImage: company.pathToAvatar != null ? NetworkImage(company.pathToAvatar) : AssetImage("assets/company_logo_temp.jpg"),
          ),
        ),
        ListTile(
          leading: Icon(Icons.assignment),
          title: Text(
            'Vos Commandes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompanyOrdersView(
                            orderStatus: 'Toutes vos commandes',
                          )),
                );
              },
              child: Text(
                'Tout voir',
                style: TextStyle(
                  color: Color(0xff3e97b7),
                  fontSize: 12.0,
                ),
              )),
        ),
        Column(
          children: <Widget>[
            ListTile(
              title: Text(
                'En cours',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompanyOrdersView(
                            orderStatus: 'En cours',
                          )),
                );
              },
            ),
            ListTile(
              title: Text(
                'Expédiées',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompanyOrdersView(
                            orderStatus: 'Expédiées',
                          )),
                );
              },
            ),
            ListTile(
              title: Text(
                'Livrées',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompanyOrdersView(
                            orderStatus: 'Livrées',
                          )),
                );
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: Divider(
            height: 1,
            color: Colors.grey[800],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: Divider(
            height: 1,
            color: Colors.grey[800],
          ),
        ),
        ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('Informations entreprise'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CompanyInformationView()),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: Divider(
            height: 1,
            color: Colors.grey[800],
          ),
        ),
        ListTile(
          title: Text('Déconnexion'),
          onTap: () async {
            final bool _logout = await LogOut().confirm(context);
            if (_logout != null) {
              disconnect(_logout, context);
            }
          },
        ),
      ],
    ));
  }
}
