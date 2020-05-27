import 'package:flutter/material.dart';

import 'package:tryme/Globals.dart';
import 'package:tryme/widgets/ProductCard.dart';

class OrderCard extends StatelessWidget {
  OrderCard({this.order});

  final double borderRadius = 12.0;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: (Container(
          height: 160,
          color: Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Commande n° ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Statut',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    (order.status == 'paid')
                        ? Text(
                            "Payée",
                            style: TextStyle(color: Colors.green[400]),
                          )
                        : (order.status == 'waiting for payment')
                            ? Text(
                                "Non payée",
                                style: TextStyle(color: Colors.orange[400]),
                              )
                            : Text(''),
                  ],
                ),
                  Column(
                    children: order.products.map((e) => ProductCard(product: e)).toList()
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nombres d\'articles',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(''),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Prix total',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Text(''),
                  ],
                ),
//                Expanded(
//                  child: Align(
//                    alignment: Alignment.topLeft,
//                    child:
//                ),
//                Expanded(
//                  child: Align(
//                      alignment: Alignment.center,
//                      child: (order.status == 'paid')
//                          ? Text(
//                              "Payée",
//                              style: TextStyle(color: Colors.green[400]),
//                            )
//                          : (order.status == 'waiting for payment')
//                              ? Text(
//                                  "Non payée",
//                                  style: TextStyle(color: Colors.orange[400]),
//                                )
//                              : Text('')),
//                ),
//                Expanded(
//                  child: Align(
//                    alignment: Alignment.bottomRight,
//                    child: Text(
//                      'Total: ' + order.total.toString() + '€',
//                      style: TextStyle(
//                          color: Colors.green,
//                          fontSize: 18.0,
//                          fontWeight: FontWeight.bold),
//                    ),
//                  ),
//                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
