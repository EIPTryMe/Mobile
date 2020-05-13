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
    user.pathToAvatar = auth0User.picture;
  }

  static void getCompany(Map result) {
    company.id = result['id'];
    company.name = result['name'];
    company.address = result['address'];
    //company.phoneNumber = result['phone'];
    company.email = result['email'];
    company.siret = result['siret'];
    company.pathToAvatar = auth0User.picture;
  }

  static Product getProduct(Map result) {
    Product product = Product();
    product.id = result['id'];
    product.name = result['name'];
    product.pricePerDay = result['price_per_day'] != null
        ? result['price_per_day'].toDouble()
        : null;
    product.pricePerWeek = result['price_per_week'] != null
        ? result['price_per_week'].toDouble()
        : null;
    product.pricePerMonth = result['price_per_month'] != null
        ? result['price_per_month'].toDouble()
        : null;
    product.descriptions = result['product_descriptions'];
    product.specifications = result['product_specifications'];
    return (product);
  }

  static Product getProductHome(Map result) {
    Product product = Product();
    product.id = result['id'];
    product.name = result['name'];
    product.pricePerDay = result['price_per_day'] != null
        ? result['price_per_day'].toDouble()
        : null;
    product.pricePerWeek = result['price_per_week'] != null
        ? result['price_per_week'].toDouble()
        : null;
    product.pricePerMonth = result['price_per_month'] != null
        ? result['price_per_month'].toDouble()
        : null;
    return (product);
  }

  static void getShoppingCard(List result) {
    shoppingCard.clear();
    result.forEach((element) {
      Product product = Product();
      product.name = element['product']['name'];
      product.pricePerDay = element['product']['price_per_day'] != null
          ? element['product']['price_per_day'].toDouble()
          : null;
      product.pricePerWeek = element['product']['price_per_week'] != null
          ? element['product']['price_per_week'].toDouble()
          : null;
      product.pricePerMonth = element['product']['price_per_month'] != null
          ? element['product']['price_per_month'].toDouble()
          : null;
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
}

class Queries {
  static String products() => '''
  query {
    product {
      name
      id
      price_per_month
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
    }
  }
  ''';

  static String company(String uid) => '''
  query {
    user(where: {uid: {_eq: "$uid"}}) {
      id
      name
      address
      phone
      email
    }
  }
  ''';

  static String shoppingCard(String uid) => '''
  query {
    user(where: {uid: {_eq: "$uid"}}) {
      carts {
        product {
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
      price_per_day
      price_per_week
      price_per_month
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
