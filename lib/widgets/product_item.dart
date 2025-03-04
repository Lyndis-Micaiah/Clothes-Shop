import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        title: Text(product.title, textAlign: TextAlign.center),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/product-detail', arguments: product.id);
        },
        child: Image.network(product.imageUrl, fit: BoxFit.cover),
      ),
    );
  }
}
