import 'package:e_commerce_app/data/product.dart';
import 'package:e_commerce_app/models/category.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({
    super.key,
    required this.imageUrl,
    required this.category,
  });

  final String imageUrl;
  final Categories category;

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts() {
      final filteredProducts =
          products.where((product) => product.category == category).toList();

      return filteredProducts;
    }

    return GestureDetector(
      onTap: () {
        context.go(
          '/category_screen',
          extra: filteredProducts(),
        );
      },
      child: Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageUrl, width: 80),
            const SizedBox(height: 12),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
