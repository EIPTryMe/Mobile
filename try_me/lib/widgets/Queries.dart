import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

class Queries {
  static String products() => '''
  {
    product {
      name,
      id,
      price_per_month
    }
  }
  ''';

  static String product(int id) => '''
  {
    product(where: {id: {_eq: $id}}) {
      name,
      id,
      price_per_day,
      price_per_week,
      price_per_month
    }
  }
  ''';
}