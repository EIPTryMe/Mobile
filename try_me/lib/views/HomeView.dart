import 'package:flutter/material.dart';
import 'package:tryme/main.dart';
import 'package:tryme/widgets/Product.dart';
import 'package:tryme/widgets/Queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/* = [
    Product(
        id: 1,
        title: 'iPhone 8',
        description: 'This is a short description',
        image:
            'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone8-plus-gold-select-2018?wid=441&hei=529&fmt=jpeg&qlt=95&op_usm=0.5,0.5&.v=1550795417455',
        price: 20.0),
    Product(
        id: 2,
        title: 'TV Samsung',
        description: 'This is a short description',
        image:
            'https://image.darty.com/hifi_video/televiseurs-led/grand_ecran_led/samsung_55nu7093_s1812264640349A_171548641.jpg',
        price: 30.0),
    Product(
        id: 3,
        title: 'MacBook Air',
        description: 'This is a short description',
        image:
            'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/macbook-air-gold-select-201810?wid=892&hei=820&&qlt=80&.v=1541713859040',
        price: 35.0),
    Product(
        id: 4,
        title: 'Dell Alienware',
        description: 'This is a short description',
        image:
            'https://i.dell.com/is/image/DellContent//content/dam/global-site-design/product_images/dell_client_products/desktops/alienware_desktops/aurora-r5/global_spi/desktop-alienware-aurora-gray-left-hero-504x350.psd?fmt=jpg&wid=570&hei=400',
        price: 32.0),
    Product(
        id: 5,
        title: 'Clevo P775TM1-G',
        description: 'This is a short description',
        image:
            'https://img.bfmtv.com/c/1256/708/e6f/e86b7e0c0b84295c19ef3a74df78d.jpg',
        price: 42.0),
    Product(
        id: 6,
        title: 'Casque audio MrSpeakers Ether Cx',
        description: 'This is a short description',
        image:
            'https://massdrop-s3.imgix.net/product-images/drop-mrspeakers-ether-cx-closed-headphones/FP/1uUtL9OjSaylYfaRmqJI_1080x1080_MD-89524_01.png?auto=format&fm=jpg&fit=fill&w=820&h=547&bg=f0f0f0&dpr=1&q=70',
        price: 18.0),
    Product(
        id: 7,
        title: 'Toyota Supra MK4',
        description: 'This is a short description',
        image:
            'https://cdn.shopify.com/s/files/1/0077/2099/2832/products/Supra_JZA80_CEIKA_2000x.jpg?v=1575631738',
        price: 180.0),
    Product(
        id: 8,
        title: 'Babyfoot Bonzini',
        description: 'This is a short description',
        image:
            'https://sportibel.com/669-large_default/babyfoot-bonzini-modele-b90.jpg',
        price: 38.0),
    Product(
        id: 9,
        title: 'Imprimante 3D M200 Plus',
        description: 'This is a short description',
        image: 'https://www.gotronic.fr/ori-imprimante-3d-m200-plus-29700.jpg',
        price: 19.0),
    Product(
        id: 10,
        title: 'Fixie State Bicycle - Rutherford',
        description: 'This is a short description',
        image:
            'https://www.beastybike.com/7110-large_default/fixie-state-bicycle-rutherford.jpg',
        price: 23.0),
    Product(
        id: 11,
        title: 'Robot Nao',
        description: 'This is a short description',
        image:
            'https://static.turbosquid.com/Preview/2017/07/06__13_49_49/nao_45.jpg5A3E2A08-9730-4A48-B057-49CD3391FB97Zoom.jpg',
        price: 12.0)
  ];*/

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List products = List();

  void getData() async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(documentNode: gql(Queries.products()));
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
    setState(() {
      products = result.data['product'];
    });
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
        body: ProductList(products: products),
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}
