import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'T-Shirt',
      description: 'Cotton t-shirt',
      price: 19.99,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      id: 'p2',
      title: 'Jeans',
      description: 'Denim jeans',
      price: 39.99,
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  List<Product> get items => [..._items];

  Product findById(String id) => _items.firstWhere((prod) => prod.id == id);
}
