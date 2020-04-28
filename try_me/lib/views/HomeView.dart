import 'package:flutter/material.dart';
import 'package:tryme/main.dart';
import 'package:tryme/views/LoginView.dart';
import 'package:tryme/views/PersonalInformationView.dart';
import 'package:tryme/views/ShoppingBasketView.dart';
import 'package:tryme/widgets/Product.dart';
import 'package:tryme/widgets/Queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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

  Icon customIcon = Icon(Icons.search);
  Widget customSearchBar = Text('TryMe');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                }
                else {
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
      ),
      drawer: Drawer(
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
                title: Text('Inscription'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                  );
                },
              ),
              Divider(
                height: 1,
                color: Colors.grey[800],
              ),
              ListTile(
                title: Text('Connexion'),
              ),
              Divider(
                height: 1,
                color: Colors.grey[800],
              ),
              ListTile(
                title: Text('Informations personnelles'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PersonalInformationView()),
                  );
                },
              )
            ],
          )),
      body: ProductList(products: products),
      backgroundColor: Colors.grey[200],
    );
  }
}
