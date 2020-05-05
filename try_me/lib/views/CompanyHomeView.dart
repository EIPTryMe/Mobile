import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tryme/views/CompanyInformationView.dart';
import 'package:tryme/views/HomeView.dart';
import 'package:tryme/Dialogs.dart';
import 'package:tryme/views/CompanyOrdersView.dart';
import 'package:tryme/Globals.dart' as globals;

class CompanyHomeView extends StatefulWidget {
  @override
  _CompanyHomeViewState createState() => _CompanyHomeViewState();
}

class _CompanyHomeViewState extends State<CompanyHomeView> {
  void disconnect(bool _yes) {
    if (_yes) {
      setState(() {
        globals.isLoggedIn = false;
        if (globals.isACompany) globals.isACompany = false;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeView()),
        );
      });
    }
  }

  Icon customIcon = Icon(Icons.search);
  Widget customSearchBar = Text('TryMe');

  Widget _appbar() {
    return AppBar(
      actions: <Widget>[
        IconButton(
          onPressed: () {
            setState(() {
              if (this.customIcon.icon == Icons.search) {
                this.customIcon = Icon(Icons.cancel);
                this.customSearchBar = TextField(
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search articles",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                );
              } else {
                this.customIcon = Icon(Icons.search);
                this.customSearchBar = Text('TryMe');
              }
            });
          },
          icon: customIcon,
        ),
      ],
      title: customSearchBar,
      centerTitle: true,
      backgroundColor: Color(0xfff99e38),
    );
  }

  Widget _drawerCompany() {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfff7892b), Color(0xfffbb448)]),
          ),
          accountName: Text(
            globals.company.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          accountEmail: Text(globals.company.email),
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage(globals.company.pathToAvatar),
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
                  MaterialPageRoute(builder: (context) => CompanyOrdersView(orderStatus: 'Toutes vos commandes',)),
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
                  MaterialPageRoute(builder: (context) => CompanyOrdersView(orderStatus: 'En cours',)),
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
                  MaterialPageRoute(builder: (context) => CompanyOrdersView(orderStatus: 'Expédiées',)),
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
                  MaterialPageRoute(builder: (context) => CompanyOrdersView(orderStatus: 'Livrées',)),
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
              disconnect(_logout);
            }
          },
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      drawer: _drawerCompany(),
      body: Center(
        child: Text('CompanyHomeView'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );
  }
}







