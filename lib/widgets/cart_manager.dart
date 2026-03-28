class CartItem {
  final dynamic product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}

class CartManager {
  static final List<CartItem> _items = [];

  static List<CartItem> get items => _items;

  static void addToCart(dynamic product, int quantity) {
    int index = _items.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      _items[index].quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
  }

  static double get subtotal {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }
}