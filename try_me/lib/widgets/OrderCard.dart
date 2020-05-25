import 'package:flutter/material.dart';

import 'package:tryme/Globals.dart';

class OrderCard extends StatelessWidget {
  OrderCard({this.order});

  final double borderRadius = 12.0;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          /*decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                offset: Offset(1.0, 2.0),
                spreadRadius: 0.0,
                blurRadius: 1.0,
              ),
            ],
          ),*/
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
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Commande n° ',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.center,
                          child: (order.status == 'paid')
                              ? Text(
                                  "Payée",
                                  style: TextStyle(color: Colors.green[400]),
                                )
                              : (order.status == 'waiting for payment')
                                  ? Text(
                                      "Non payée",
                                      style:
                                          TextStyle(color: Colors.orange[400]),
                                    )
                                  : Text('')),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Total: ' + order.total.toString() + '€',
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
                onTap: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
