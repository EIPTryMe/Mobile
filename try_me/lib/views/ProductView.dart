import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tryme/widgets/Queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tryme/Globals.dart' as globals;


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
  Map product = Map();
  List productDescriptions = List();
  List productSpecifications = List();

  void getData() async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(documentNode: gql(Queries.product(widget.id)));
    result = await globals.graphQLConfiguration.clientToQuery.query(queryOption);
    if (this.mounted) {
      setState(() {
        product = result.data['product'][0];
        productDescriptions = product['product_descriptions'];
        productSpecifications = product['product_specifications'];
        //print(productDescriptions[3]['name']);
        //print(productDescriptions.length);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff99e38),
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
                          product['name'] == null ? '' : product['name'],
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          product['price_per_day'] == null ? '' : product['price_per_day'].toString() + '€/Jour',
                          style: TextStyle(color: Colors.green, fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          product['price_per_week'] == null ? '' : product['price_per_week'].toString() + '€/Semaine',
                          style: TextStyle(color: Colors.green, fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          product['price_per_month'] == null ? '' : product['price_per_month'].toString() + '€/Mois',
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
                          children: productDescriptions.map((value) => Text(value['name'])).toList(),
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
                          children: productSpecifications.map((value) => Text(value['name'])).toList(),
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
                onPressed: () {},
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
