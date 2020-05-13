import 'package:flutter/material.dart';

import 'package:tryme/Globals.dart';

class ProductShoppingCartCard extends StatelessWidget {
  ProductShoppingCartCard({this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 160,
          color: Colors.grey[100],
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  child: Image.network(
                    'https://i.redd.it/ugaauduw5ks31.png',
                    fit: BoxFit.cover,
                  ),
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
                            'Quantité: ' + shoppingCard[id].toString(),
                            //product['name'] == null ? '' : product['name'],
                            //product.title,
                            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            '',
                            //product['price_per_month'] == null ? '' : product['price_per_month'].toString() + '€/Mois',
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
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white10,
              onTap: () {},
              //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductView(id: product['id']))),
            ),
          ),
        ),
      ],
    );
  }
}
