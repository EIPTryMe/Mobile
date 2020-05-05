import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:tryme/Globals.dart';
import 'package:tryme/Queries.dart';

List images = [
  'https://cdn.futura-sciences.com/buildsv6/images/mediumoriginal/6/5/2/652a7adb1b_98148_01-intro-773.jpg',
  'https://i.redd.it/ugaauduw5ks31.png',
  'https://media.ldlc.com/r1600/ld/products/00/05/44/01/LD0005440118_2_0005440195_0005440280.jpg',
  'https://media.ldlc.com/r1600/ld/products/00/05/44/01/LD0005440128_2_0005440203_0005440288.jpg',
  'https://media.ldlc.com/r1600/ld/products/00/05/44/01/LD0005440123_2_0005440199_0005440284.jpg'
];

class ProductView extends StatefulWidget {
  ProductView({this.id});

  final int id;

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  Product product = Product();

  void getData() async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(documentNode: gql(Queries.product(widget.id)));
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
    if (this.mounted) {
      setState(() {
        product = Product();
        product.id = result.data['product'][0]['id'];
        product.name = result.data['product'][0]['name'];
        product.pricePerDay = result.data['product'][0]['price_per_day'];
        product.pricePerWeek = result.data['product'][0]['price_per_week'];
        product.pricePerMonth = result.data['product'][0]['price_per_month'];
        product.descriptions = result.data['product'][0]['product_descriptions'];
        product.specifications = result.data['product'][0]['product_specifications'];
      });
    }
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
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff99e38),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/shoppingCard'),
          )
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
                  height: 400,
                  child: Builder(builder: (context) {
                    double width = MediaQuery.of(context).size.width;
                    double height = MediaQuery.of(context).size.height;
                    return CarouselSlider(
                      items: images
                          .asMap()
                          .map((i, item) => MapEntry(
                        i,
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context, MaterialPageRoute(builder: (context) => CarouselFullscreen(images: images, current: i))),
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
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        product.pricePerDay == null ? '' : product.pricePerDay.toString() + '€/Jour',
                        style: TextStyle(color: Colors.green, fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        product.pricePerWeek == null ? '' : product.pricePerWeek.toString() + '€/Semaine',
                        style: TextStyle(color: Colors.green, fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        product.pricePerMonth == null ? '' : product.pricePerMonth.toString() + '€/Mois',
                        style: TextStyle(color: Colors.green, fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Description',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: product.descriptions.map((value) => Text(value['name'])).toList(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Spécification',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
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
          Expanded(
            flex: 1,
            child: FlatButton(
              color: Color(0xfff99e38),
              onPressed: () {
                if (shoppingCard.containsKey(widget.id))
                  shoppingCard[widget.id]++;
                else
                  shoppingCard[widget.id] = 1;
                addedToCardOverlay(context);
                print(shoppingCard.length);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ajouter au panier  ', style: TextStyle(color: Colors.white, fontSize: 18)),
                  Icon(Icons.add_shopping_cart, color: Colors.white),
                ],
              ),
            ),
          ),
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
