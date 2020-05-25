import 'package:tryme/Globals.dart';

class QueryParse {
  static void getUser(Map result) {
    user.id = result['id'];
    user.firstName = result['first_name'];
    user.lastName = result['name'];
    user.address = result['address'];
    //user.phoneNumber = result['phone'];
    user.email = result['email'];
    user.birthDate = result['birth_date'];
    user.companyId = result['company_id'];
    user.pathToAvatar = auth0User.picture;
  }

  static void getCompany(Map result) {
    company.id = result['id'];
    company.name = result['name'];
    company.address = result['address'];
    //company.phoneNumber = result['phone'];
    company.email = result['email'];
    company.siret = result['siret'];
    company.siren = result['siren'];
  }

  static Product getProduct(Map result) {
    Product product = Product();
    product.id = result['id'];
    product.name = result['name'];
    product.brand = result['brand'];
    product.pricePerDay = result['price_per_day'] != null ? result['price_per_day'].toDouble() : null;
    product.pricePerWeek = result['price_per_week'] != null ? result['price_per_week'].toDouble() : null;
    product.pricePerMonth = result['price_per_month'] != null ? result['price_per_month'].toDouble() : null;
    product.stock = result['stock'];
    product.descriptions = result['product_descriptions'];
    product.specifications = result['product_specifications'];
    return (product);
  }

  static Product getProductHome(Map result) {
    Product product = Product();
    product.id = result['id'];
    product.name = result['name'];
    product.pricePerDay = result['price_per_day'] != null ? result['price_per_day'].toDouble() : null;
    product.pricePerWeek = result['price_per_week'] != null ? result['price_per_week'].toDouble() : null;
    product.pricePerMonth = result['price_per_month'] != null ? result['price_per_month'].toDouble() : null;
    return (product);
  }

  static void getShoppingCard(List result) {
    shoppingCard.clear();
    result.forEach((element) {
      Product product = Product();
      product.id = element['product']['id'];
      product.name = element['product']['name'];
      product.pricePerDay = element['product']['price_per_day'] != null ? element['product']['price_per_day'].toDouble() : null;
      product.pricePerWeek = element['product']['price_per_week'] != null ? element['product']['price_per_week'].toDouble() : null;
      product.pricePerMonth = element['product']['price_per_month'] != null ? element['product']['price_per_month'].toDouble() : null;
      Cart cart = Cart(product: product);
      shoppingCard.add(cart);
    });
  }
}

class Mutations {
  static String addProduct(int id) => '''
  mutation {
    createCartItem(product_id: $id) {
      id
    }
  }
  ''';

  static String deleteShoppingCard(String user_uid, int product_id) => '''
  mutation {
    delete_cart(where: {product_id: {_eq: $product_id}, user_uid: {_eq: "$user_uid"}}) {
      affected_rows
    }
  }
  ''';

  static String modifyUser(int id, String lastName, String firstName, String address, String email, String phoneNumber, String birthDate) => '''
  mutation {
    update_user(_set: {name: "$lastName", first_name: "$firstName", email: "$email", address: "$address", phone: 0, birth_date: "$birthDate"}, where: {id: {_eq: $id}}) {
     returning {
        address
        birth_date
        email
        first_name
        name
        phone
      }
    }
  }
  ''';

  static String modifyProduct(int id, String title, String brand, double monthPrice, double weekPrice, double dayPrice, int stock/*, String description, String specification*/) => '''
  mutation {
    update_product(_set: {name: "$title", brand: "$brand", price_per_month: "$monthPrice", price_per_week: "$weekPrice", price_per_day: "$dayPrice", stock: $stock}, where: {id: {_eq: $id}}) {
      affected_rows
    }
  }
  ''';

  static String orderPayment(String currency, String city, String country, String address, int postalCode) => '''
  mutation {
    orderPayment(currency: "$currency", addressDetails: {address_city: "$city", address_country: "$country", address_line_1: "$address", address_postal_code: $postalCode}) {
      order_id
      clientSecret
      publishableKey
    }
  }
  ''';

  static String payOrder(int orderId) => '''
  mutation {
    payOrder(order_id: $orderId) {
      stripe_id
    }
  }
  ''';
}

class Queries {
  static String productsName(bool asc) => '''
  query {
    product(order_by: {name:  ''' + (asc ? 'asc' : 'desc') + '''}) {
      name
      id
      price_per_week
      price_per_month
      price_per_day
    }
  }
  ''';

  static String productsPrice(bool asc) => '''
  query {
    product(order_by: {price_per_month: ''' + (asc ? 'asc' : 'desc') + ''', name: asc}) {
      name
      id
      price_per_week
      price_per_month
      price_per_day
    }
  }
  ''';

  static String productsCompany(int id) => '''
  query {
    company(where: {id: {_eq: $id}}) {
      products {
        name
        id
        price_per_week
        price_per_month
        price_per_day
      }
    }
  }
  ''';

  static String orders(String status) => '''
  {
    order(where: {order_statuses: {status: {_eq: "$status"}}, user_uid: {_eq: "${auth0User.uid}"}}) {
      order_items {
        price
      }
      id
    }
  }
  ''';

  static String user(String uid) => '''
  query {
    user(where: {uid: {_eq: "$uid"}}) {
      id
      first_name
      name
      address
      birth_date
      phone
      email
      company_id
    }
  }
  ''';

  static String company(int id) => '''
  query {
    company(where: {id: {_eq: $id}}) {
      address
      email
      id
      name
      phone
      siret
      siren
    }
  }
  ''';

  static String shoppingCard(String uid) => '''
  query {
    user(where: {uid: {_eq: "$uid"}}) {
      cartsUid {
        product {
          id
          name
          price_per_week
          price_per_month
          price_per_day
        }
      }
    }
  }
  ''';

  static String product(int id) => '''
  query {
    product(where: {id: {_eq: $id}}) {
      id
      name
      brand
      price_per_day
      price_per_week
      price_per_month
      stock
      product_descriptions {
        name
      }
      product_specifications {
        name
      }
    }
  }
  ''';
}
