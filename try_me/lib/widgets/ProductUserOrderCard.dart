import 'package:flutter/material.dart';

import 'package:tryme/Globals.dart';

class ProductUserOrderCard extends StatelessWidget {
  ProductUserOrderCard({this.product});

  final ProductOrder product;
  final double borderRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: (Container(
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
                                product.name == null ? '' : product.name,
                                //product.title,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              product.status == null ? '' : product.status,
                              //product.title,
                              style: TextStyle(
                                  fontSize: 15.0, fontStyle: FontStyle.italic,
                              color: (product.status == "Livrée") ? Colors.green[400] : (product.status == "Expédiée") ? Colors.orange[400] : Colors.black,
                              ),
                            ),
                          )),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                product.pricePerMonth == null
                                    ? ''
                                    : product.pricePerMonth.toString() +
                                        '€/Mois',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
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
                onTap: () => Navigator.pushNamed(context, 'product/${product.id}'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
