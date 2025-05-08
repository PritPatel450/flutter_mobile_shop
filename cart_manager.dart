import 'product_list_screen.dart';

class CartManager {
  static final List<Product> cartItems = [];

  static void addToCart(Product product) {
    if (!cartItems.contains(product)) {
      cartItems.add(product);
    }
  }

  static void removeFromCart(Product product) {
    cartItems.remove(product);
  }

  static double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.price);
}
