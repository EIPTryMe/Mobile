import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tryme/Globals.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _MyAppBarState extends State<MyAppBar> {
  Icon customIcon = Icon(Icons.search);
  Widget customSearchBar = Text('TryMe');

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        IconButton(
          onPressed: () {
            setState(() {
              if (this.customIcon.icon == Icons.search) {
                this.customIcon = Icon(Icons.cancel);
                this.customSearchBar = TextField(
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search articles",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                );
              } else {
                this.customIcon = Icon(Icons.search);
                this.customSearchBar = Text('TryMe');
              }
            });
          },
          icon: customIcon,
        ),
        if (!isACompany)
          IconButton(
            onPressed: () => Navigator.pushNamed(context, 'shoppingCard'),
            icon: Icon(Icons.shopping_cart),
          ),
      ],
      title: customSearchBar,
      centerTitle: true,
      backgroundColor: Color(0xfff99e38),
    );
  }
}
