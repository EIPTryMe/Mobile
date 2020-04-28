import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

class Queries {
  static String products() => '''
  {
    product {
<<<<<<< HEAD
      name,
      id,
=======
      name
      id
      price_per_month
    }
  }
  ''';

  static String product(int id) => '''
  {
    product(where: {id: {_eq: $id}}) {
      name
      id
      price_per_day
      price_per_week
      price_per_month
>>>>>>> e485e025358e64bfb4e3fdf4eeb532d996b667b4
    }
  }
  ''';
}