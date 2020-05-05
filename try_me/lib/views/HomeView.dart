import 'package:flutter/material.dart';
import 'package:tryme/views/AuthenticationView.dart';
import 'package:tryme/views/PersonalInformationView.dart';
import 'package:tryme/views/ShoppingCardView.dart';
import 'package:tryme/views/UserOrdersView.dart';
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
    QueryOptions queryOption =
        QueryOptions(documentNode: gql(Queries.products()));
    result =
        await globals.graphQLConfiguration.clientToQuery.query(queryOption);
    if (this.mounted)
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
              MaterialPageRoute(builder: (context) => ShoppingCardView()),
            );
          },
          icon: Icon(Icons.shopping_cart),
        ),
      ],
      title: customSearchBar,
      centerTitle: true,
      backgroundColor: Color(0xfff99e38),
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

  Widget _drawerIsConnected() {
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
            globals.user.firstName != null
                ? globals.user.firstName
                : 'Pas de prénom défini',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          accountEmail: Text(globals.user.email != null
              ? globals.user.email
              : "Pas d'email défini"),
          currentAccountPicture: CircleAvatar(
            backgroundImage: globals.user.pathToAvatar != null
                ? NetworkImage(globals.user.pathToAvatar)
                : AssetImage("assets/company_logo_temp.jpg"),
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
                  MaterialPageRoute(builder: (context) => UserOrdersView(orderStatus: 'Mes Commandes',)),
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
                  MaterialPageRoute(builder: (context) => UserOrdersView(orderStatus: 'En attente',)),
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
                  MaterialPageRoute(builder: (context) => UserOrdersView(orderStatus: 'Expédiées',)),
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
                  MaterialPageRoute(builder: (context) => UserOrdersView(orderStatus: 'Livrées',)),
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
          title: Text(
            'Informations personnelles',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PersonalInformationView()),
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
