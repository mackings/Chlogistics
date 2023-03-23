class Product {
  final String name;
  final String description;
  final String type;
  int price;
  final String imageUrl;
  int? allamount;

  Product(
      {
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      required this.type,
      this.allamount,});
}

class CartModel {
  final List<Product> items = [];

  void addItem(Product item) {
    items.add(item);
  }

  void removeItem(Product item) {
    items.remove(item);
  }

  double get total {
    return items.fold(0, (total, Product) => total + Product.price);
  }
}
