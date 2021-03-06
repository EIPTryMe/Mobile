import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:tryme/Globals.dart';
import 'package:tryme/GraphQLConfiguration.dart';
import 'package:tryme/Queries.dart';
import 'package:tryme/Request.dart';

/*List images = [
  'https://cdn.futura-sciences.com/buildsv6/images/mediumoriginal/6/5/2/652a7adb1b_98148_01-intro-773.jpg',
  'https://i.redd.it/ugaauduw5ks31.png',
  'https://media.ldlc.com/r1600/ld/products/00/05/44/01/LD0005440118_2_0005440195_0005440280.jpg',
  'https://media.ldlc.com/r1600/ld/products/00/05/44/01/LD0005440128_2_0005440203_0005440288.jpg',
  'https://media.ldlc.com/r1600/ld/products/00/05/44/01/LD0005440123_2_0005440199_0005440284.jpg'
];*/

class ProductView extends StatefulWidget {
  ProductView({this.id});

  final String id;

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  Product product = Product();
  bool gotData = false;

  Future getData() async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(documentNode: gql(Queries.product(int.parse(widget.id))));
    graphQLConfiguration = GraphQLConfiguration();
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
    if (this.mounted) {
      setState(() {
        product = QueryParse.getProduct(result.data['product'][0]);
      });
    }
  }

  void addProduct() async {
    if (auth0User.uid == null) return;
    QueryResult result;
    QueryOptions queryOption = QueryOptions(documentNode: gql(Mutations.addProduct(int.parse(widget.id))));
    result = await graphQLConfiguration.getClientToQuery(auth0User.uid).query(queryOption);
    addedToCardOverlay(context);
    Request.getShoppingCard();
  }

  void addedToCardOverlay(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 100,
        height: 35,
        top: MediaQuery.of(context).size.height - 100,
        right: MediaQuery.of(context).size.width / 2 - 100 / 2,
        child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border.all(width: 0.8, color: Colors.grey[400]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                child: Center(child: Text('Produit ajouté')),
              ),
            )),
      ),
    );
    overlayState.insert(overlayEntry);
    await Future.delayed(Duration(seconds: 2));
    overlayEntry.remove();
  }

  @override
  void initState() {
    super.initState();
    getData().whenComplete(() {
      if (this.mounted)
      setState(() {
        gotData = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1F2C47),
        actions: !isLoggedIn
            ? null
            : [
                (() {
                  if (isACompany)
                    return IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => Navigator.pushNamed(context, 'productEdit/${widget.id}'),
                    );
                  else
                    return IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () => Navigator.pushNamed(context, 'shoppingCard'),
                    );
                }())
              ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 12,
            child: ListView(
              children: <Widget>[
                Container(
                  color: Colors.grey[300],
                  height: 400,
                  child: product.pictures == null ? null : Builder(builder: (context) {
                    double width = MediaQuery.of(context).size.width;
                    double height = MediaQuery.of(context).size.height;
                    return CarouselSlider(
                      items: product.pictures == null ? null : product.pictures
                          .asMap()
                          .map((i, item) => MapEntry(
                                i,
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => CarouselFullscreen(images: product.pictures, current: i))),
                                  child: Image.network(
                                    item,
                                    fit: BoxFit.cover,
                                    width: width,
                                  ),
                                ),
                              ))
                          .values
                          .toList(),
                      options: CarouselOptions(height: height, viewportFraction: 1.0),
                    );
                  }),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        product.name == null ? '' : product.name,
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        product.brand == null ? '' : product.brand,
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      /*Text(
                        product.pricePerDay == null ? '' : product.pricePerDay.toString() + '€/Jour',
                        style: TextStyle(color: Colors.green, fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        product.pricePerWeek == null ? '' : product.pricePerWeek.toString() + '€/Semaine',
                        style: TextStyle(color: Colors.green, fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),*/
                      Text(
                        product.pricePerMonth == null ? '' : product.pricePerMonth.toString() + '€/Mois',
                        style: TextStyle(color: Colors.green, fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Description',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      if (product.description != null)
                        Text(
                          product.description
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Spécification',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      if (product.specifications != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: product.specifications.map((value) => Text(value['name'])).toList(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isLoggedIn && !isACompany && gotData)
            (() {
              if (product.stock > 0)
                return Expanded(
                  flex: 1,
                  child: FlatButton(
                    color: Color(0xff58c24c),
                    onPressed: () => addProduct(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Ajouter au panier  ', style: TextStyle(color: Colors.white, fontSize: 18)),
                        Icon(Icons.add_shopping_cart, color: Colors.white),
                      ],
                    ),
                  ),
                );
              else
                return Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey[400],
                    child: Center(child: Text('Indisponible', style: TextStyle(color: Colors.white, fontSize: 18))),
                  ),
                );
            }())
        ],
      ),
    );
  }
}

class CarouselFullscreen extends StatelessWidget {
  CarouselFullscreen({this.images, this.current});

  final List images;
  final int current;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Builder(builder: (context) {
          return CarouselSlider(
            items: images
                .map((item) => GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.network(
                        item,
                        height: height,
                      ),
                    ))
                .toList(),
            options: CarouselOptions(height: height, viewportFraction: 1.0, initialPage: current),
          );
        }),
      ),
    );
  }
}
