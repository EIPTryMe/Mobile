import 'package:tryme/views/ProductView.dart';
import 'package:flutter/material.dart';

/*class Product {
  Product({this.id, this.title, this.description, this.image, this.price});

  int id;
  String title;
  String description;
  String city;
  String image;
  double price;
}*/

class ProductCard extends StatelessWidget {
  ProductCard({this.product});

  final Map product;
  final double borderRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                offset: Offset(1.0, 2.0),
                spreadRadius: 0.0,
                blurRadius: 1.0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: (Container(
              height: 160,
              color: Colors.lightBlue[200],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.white,
                      child: Image.network('https://i.redd.it/ugaauduw5ks31.png', fit: BoxFit.cover,),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                product['name'] == null ? '' : product['name'],
                                //product.title,
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                product['price_per_month'] == null ? '' : product['price_per_month'].toString() + '€/Mois',
                                style: TextStyle(color: Colors.green, fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ),
        ),
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.white10,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductView(id: product['id']))),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProductList extends StatefulWidget {
  ProductList({this.products});

  final List products;

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.products
          .map((product) => Padding(
                padding: const EdgeInsets.all(3.0),
                child: ProductCard(
                  product: product,
                ),
              ))
          .toList(),
    );
  }
}
