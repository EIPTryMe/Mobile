import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

class Queries {
  String products() => '''
  query {
    product {
      name,
      id,
    }
  }
  ''';
}