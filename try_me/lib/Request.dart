import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:tryme/Globals.dart';
import 'package:tryme/Queries.dart';

class Request {
  static void getShoppingCard() async {
    if (auth0User.uid == null) return;
    QueryResult result;
    QueryOptions queryOption = QueryOptions(documentNode: gql(Queries.shoppingCard(auth0User.uid)));
    result = await graphQLConfiguration.getClientToQuery(user.id.toString()).query(queryOption);
    QueryParse.getShoppingCard(result.data['user'][0]['carts']);
  }

  static Future getUser() async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(documentNode: gql(Queries.user(auth0User.uid)));
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
    QueryParse.getUser(result.data['user'][0]);
  }

  static Future getCompany() async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(documentNode: gql(Queries.company(auth0User.uid)));
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
    QueryParse.getCompany(result.data['user'][0]);
  }

  static Future modifyUser() async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(documentNode: gql(Mutations.modifyUser(user.id, user.lastName, user.firstName, user.address, user.email, user.phoneNumber, user.birthDate)));
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
  }
}
