class Queries {
  static String products() => '''
  {
    product {
      name
      id
      price_per_month
    }
  }
  ''';

  static String user(String uid) => '''
  {
    user(where: {uid: {_eq: "$uid"}}) {
      first_name
      name
      address
      birth_date
      phone
      email
    }
  }  ''';

  static String company(String uid) => '''
  {
    user(where: {uid: {_eq: "$uid"}}) {
      name
      address
      phone
      email
    }
  }  ''';

  static String product(int id) => '''
  {
    product(where: {id: {_eq: $id}}) {
      name
      id
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