import 'package:flutter/material.dart';

class CompanyInformationView extends StatefulWidget {
  @override
  _CompanyInformationViewState createState() => _CompanyInformationViewState();
}

class _CompanyInformationViewState extends State<CompanyInformationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informations entreprise'),
      ),
    );
  }
}
