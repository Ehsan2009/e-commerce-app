import 'package:e_commerce_app/components/product_container.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('There is no cloth here, Add some!'),
    );

    mainContent = GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 8 / 10,
        crossAxisCount: 2,
      ),
      itemCount: products.length,
      itemBuilder: (ctx, index) {
        return ProductContainer(product: products[index]);
      },
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/home_screen');
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: mainContent,
      ),
    );
  }
}
