import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:tryme/Globals.dart';
import 'package:tryme/Queries.dart';

class Request {
  static void getShoppingCard() async {
    if (auth0User.uid == null) return;
    QueryResult result;
    QueryOptions queryOption = QueryOptions(documentNode: gql(Queries.shoppingCard(auth0User.uid)));
    result = await graphQLConfiguration.getClientToQuery(auth0User.uid).query(queryOption);
    QueryParse.getShoppingCard(result.data['user'][0]['cartsUid']);
  }

  static void deleteShoppingCard(int id) async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(documentNode: gql(Mutations.deleteShoppingCard(auth0User.uid, id)));
    result = await graphQLConfiguration.getClientToQuery(auth0User.uid).query(queryOption);
  }

  static Future getUser() async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(documentNode: gql(Queries.user(auth0User.uid)));
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
    QueryParse.getUser(result.data['user'][0]);
  }

  static Future getCompany() async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(documentNode: gql(Queries.company(user.companyId)));
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
    QueryParse.getCompany(result.data['company'][0]);
  }

  static Future modifyUser() async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(
        documentNode:
        gql(Mutations.modifyUser(auth0User.uid, user.lastName, user.firstName, user.address, user.email, user.phoneNumber, user.birthDate)));
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
  }

  static Future modifyCompany() async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(
        documentNode:
        gql(Mutations.modifyCompany(company.id, company.address, company.email, company.name, company.phoneNumber, company.siren, company.siret)));
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
  }

  static Future modifyProduct(Product product) async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(
        documentNode: gql(Mutations.modifyProduct(product.id, product.name, product.brand, product.pricePerMonth, product.pricePerWeek,
            product.pricePerDay, product.stock /*, product.description, product.specification*/)));
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
  }

  static Future order(String currency, String city, String country, String address, int postalCode) async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(documentNode: gql(Mutations.orderPayment(currency, city, country, address, postalCode)));
    result = await graphQLConfiguration.getClientToQuery(auth0User.uid).query(queryOption);
    return (result.data['orderPayment']);
  }

  static Future payOrder(int orderId) async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(documentNode: gql(Mutations.payOrder(orderId)));
    result = await graphQLConfiguration.getClientToQuery(auth0User.uid).query(queryOption);
  }
}
