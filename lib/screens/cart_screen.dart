import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<dynamic>> cartItems;

  @override
  void initState() {
    super.initState();
    cartItems = ApiService.getProducts();
  }

  void _removeFromCart(String productId) async {
    await ApiService.addToCart("user123", productId, -1);
    setState(() {
      cartItems = ApiService.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: FutureBuilder<List<dynamic>>(
        future: cartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Your cart is empty.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var item = snapshot.data![index];
              return ListTile(
                title: Text(item['name']),
                subtitle: Text("Qty: ${item['quantity']}"),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _removeFromCart(item['_id']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
