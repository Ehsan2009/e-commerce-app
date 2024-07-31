import 'package:e_commerce_app/components/product_card.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
  Box<Product> productsBox = Hive.box<Product>('products');
  List<Product> products = productsBox.values.toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Current Orders',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (ctx, index) {
          return ProductCard(
            product: products[index],
            isAdminOrderScreen: false,
          );
        },
      ),
    );
  }
}
