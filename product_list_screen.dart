import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'cart_manager.dart';

class Product {
  final String name;
  final String imagePath;
  final double price;
  final String category;

  Product({
    required this.name,
    required this.imagePath,
    required this.price,
    required this.category,
  });
}

final List<Product> allProducts = [
  Product(name: 'Nike Air Max 90', imagePath: 'assets/images/nike01.jpg', price: 137.50, category: 'Shoes'),
  Product(name: 'Crater Impact', imagePath: 'assets/images/nike02.jpg', price: 99.56, category: 'Shoes'),
  Product(name: 'Zoom Fly 4', imagePath: 'assets/images/nike03.jpg', price: 150.99, category: 'Shoes'),
  Product(name: 'Metcon 8', imagePath: 'assets/images/nike04.jpg', price: 112.00, category: 'Shoes'),
  Product(name: 'New Balance Women"s 608 V5', imagePath: 'assets/images/nike05.jpg', price: 112.00, category: 'Shoes'),

  Product(name: "Men's Winter Jacket", imagePath: 'assets/images/cloth01.jpg', price: 25.00, category: 'Clothes'),
  Product(name: 'Mens Jogger Sweatpant', imagePath: 'assets/images/cloth02.jpg', price: 45.00, category: 'Clothes'),
  Product(name: "Men's Dress Shirt", imagePath: 'assets/images/cloth03.jpg', price: 80.00, category: 'Clothes'),
  Product(name: 'Oversized T-Shirt', imagePath: 'assets/images/cloth04.jpg', price: 80.00, category: 'Clothes'),
  Product(name: 'Wrangler Long Sleeve', imagePath: 'assets/images/cloth05.jpg', price: 112.00, category: 'Clothes'),

  Product(name: 'Sunglasses', imagePath: 'assets/images/other01.jpg', price: 30.00, category: 'Accessories'),
  Product(name: "Casio Watch", imagePath: 'assets/images/other02.jpg', price: 60.00, category: 'Accessories'),
  Product(name: 'Smart Watch', imagePath: 'assets/images/other03.jpg', price: 60.00, category: 'Accessories'),
  Product(name: 'Fitbit Inspire 3', imagePath: 'assets/images/other04.jpg', price: 60.00, category: 'Accessories'),
  Product(name: 'Travel Backpack', imagePath: 'assets/images/other05.jpg', price: 112.00, category: 'Accessories'),
];

class ProductListScreen extends StatefulWidget {
  final String categoryName;

  ProductListScreen({required this.categoryName});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  void addToCart(Product product) {
    setState(() {
      CartManager.addToCart(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> categoryProducts = allProducts
        .where((product) => product.category == widget.categoryName)
        .toList();

    final cartItems = CartManager.cartItems;
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: Color(0xFFF5EFF7),
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: categoryProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isWideScreen ? 3 : 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: isWideScreen ? 1.1 : 0.85,
          ),
          itemBuilder: (context, index) {
            final product = categoryProducts[index];
            final isAdded = cartItems.contains(product);
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Image.asset(
                      product.imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  SizedBox(height: 4),
                  ElevatedButton(
                    onPressed: isAdded ? null : () => addToCart(product),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isAdded ? Colors.grey : Colors.yellow,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    ),
                    child: Text(
                      isAdded ? '✔ Added' : 'Add to Cart',
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
