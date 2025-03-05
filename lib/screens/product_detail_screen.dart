import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  void _addToCart(BuildContext context) async {
    try {
      await ApiService.addToCart("user123", product['_id'], 1);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added to Cart')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['name'])),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(product['imageUrl'], width: double.infinity, height: 250, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("\$${product['price']}", style: TextStyle(fontSize: 20, color: Colors.green)),
                SizedBox(height: 10),
                Text(product['description']),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _addToCart(context),
                  child: Text('Add to Cart'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
