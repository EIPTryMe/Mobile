import 'package:flutter/material.dart';

import 'package:tryme/widgets/AppBar.dart';
import 'package:tryme/widgets/Drawer.dart';
import 'package:tryme/Globals.dart';

class CompanyHomeView extends StatefulWidget {
  @override
  _CompanyHomeViewState createState() => _CompanyHomeViewState();
}

class _CompanyHomeViewState extends State<CompanyHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: DrawerCompany(),
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
