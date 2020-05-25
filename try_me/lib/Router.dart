import 'package:flutter/material.dart';

import 'package:fluro/fluro.dart';

import 'package:tryme/views/AuthentificationView.dart';
import 'package:tryme/views/CompanyHomeView.dart';
import 'package:tryme/views/CompanyInformationView.dart';
import 'package:tryme/views/CompanyOrdersView.dart';
import 'package:tryme/views/ProductEditView.dart';
import 'package:tryme/views/CompanySignInView.dart';
import 'package:tryme/views/HomeView.dart';
import 'package:tryme/views/PersonalInformationView.dart';
import 'package:tryme/views/ProductView.dart';
import 'package:tryme/views/ShoppingCardView.dart';
import 'package:tryme/views/SignInView.dart';
import 'package:tryme/views/SignUpView.dart';
import 'package:tryme/views/UserOrdersView.dart';

class FluroRouter {
  static Router router = Router();
  static Handler _authentificationHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => AuthentificationView());
  static Handler _companyHomeHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => CompanyHomeView());
  static Handler _companyInformationHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => CompanyInformationView());
  static Handler _companyOrdersHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => CompanyOrdersView(orderStatus: params['orderStatus'][0]));
  static Handler _companySignInHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => CompanySignInView());
  static Handler _homeHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => HomeView());
  static Handler _personalInformationHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => PersonalInformationView());
  static Handler _productHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => ProductView(id: params['id'][0]));
  static Handler _productEditHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => ProductEditView(id: params['id'][0]));
  static Handler _shoppingCardHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => ShoppingCardView());
  static Handler _signInHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => SignInView());
  static Handler _signUpHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => SignUpView());
  static Handler _userOrdersHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => UserOrdersView(orderStatus: params['orderStatus'][0]));

  static void setupRouter() {
    router.define(
      'authentification',
      handler: _authentificationHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'companyHome',
      handler: _companyHomeHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'companyInformation',
      handler: _companyInformationHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'companyOrders/:orderStatus',
      handler: _companyOrdersHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'productEdit/:id',
      handler: _productEditHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'companySignIn',
      handler: _companySignInHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'home',
      handler: _homeHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'personalInformation',
      handler: _personalInformationHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'product/:id',
      handler: _productHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'shoppingCard',
      handler: _shoppingCardHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'signIn',
      handler: _signInHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'signUp',
      handler: _signUpHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'userOrders/:orderStatus',
      handler: _userOrdersHandler,
      transitionType: TransitionType.cupertino,
    );
  }
}
