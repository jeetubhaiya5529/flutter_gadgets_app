class CatalogModel {
  static List<Item>? items;

  /// Singleton class make object only once
  // static final catModel = CatalogModel._internal();
  // CatalogModel._internal();
  // factory CatalogModel() => catModel;

  // Get item by id
  Item getById(int id) =>
      items!.firstWhere((element) => element.id == id, orElse: null);

  // get item by position
  Item getByPosition(int pos) => items![pos];

  // = [
  //   Item(
  //       id: 1,
  //       name: "Laptop",
  //       description: "Powerful laptop with high performance",
  //       price: 999.99,
  //       color: "Silver",
  //       image:
  //           "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?q=80&w=1771&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
  // ];
}

class Item {
  final int id;
  final String name;
  final String description;
  final double price;
  final String color;
  final String image;

  Item(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.color,
      required this.image});

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
        id: map["id"],
        name: map["name"],
        description: map["description"],
        price: map["price"],
        color: map["color"],
        image: map["image"]);
  }

  toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "color": color,
        "image": image
      };
}
