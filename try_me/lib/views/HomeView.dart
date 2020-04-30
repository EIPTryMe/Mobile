import 'package:flutter/material.dart';
import 'package:tryme/main.dart';
import 'package:tryme/views/AuthenticationView.dart';
import 'package:tryme/views/PersonalInformationView.dart';
import 'package:tryme/views/ShoppingBasketView.dart';
import 'package:tryme/widgets/Product.dart';
import 'package:tryme/widgets/Queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tryme/Dialogs.dart';
import 'package:tryme/views/CompanySignInView.dart';
import 'package:tryme/Globals.dart' as globals;

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List products = List();

  void getData() async {
    QueryResult result;
    Queries queries = Queries();
    QueryOptions queryOption = QueryOptions(documentNode: gql(Queries.products()));
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
    setState(() {
      products = result.data['product'];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void disconnect(bool _yes) {
    if (_yes) {
      setState(() {
        globals.isLoggedIn = false;
        if (globals.isACompany) globals.isACompany = false;
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
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShoppingBasketView()),
            );
          },
          icon: Icon(Icons.shopping_cart),
        ),
      ],
      title: customSearchBar,
      centerTitle: true,
      backgroundColor: Colors.grey[800],
    );
  }

  Widget _drawerNotConnected() {
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
              color: Colors.black,
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

  Widget _drawerIsConnected() {
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
              color: Colors.black,
            ),
          ),
        ),
        ListTile(
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

  @override
  Widget build(BuildContext context) {
    if (!globals.isLoggedIn && !globals.isACompany) {
      return Scaffold(
        appBar: _appbar(),
        drawer: _drawerNotConnected(),
        body: ProductList(products: products),
        backgroundColor: Colors.grey[200],
      );
    } else if (globals.isLoggedIn && !globals.isACompany) {
      return Scaffold(
        appBar: _appbar(),
        drawer: _drawerIsConnected(),
        body: ProductList(products: products),
        backgroundColor: Colors.grey[200],
      );
    } else {
      return Scaffold(

        body: ProductList(products: products),
        backgroundColor: Colors.grey[200],
      );
    }
  }
}
