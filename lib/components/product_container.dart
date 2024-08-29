import 'dart:io';

import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductContainer extends StatefulWidget {
  const ProductContainer({super.key, required this.product});

  final Product product;

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/details_screen', extra: widget.product);
      },
      child: Container(
        width: 140,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.product.productImagePath != null)
              Hero(
                tag: widget.product.productId,
                child: Image.file(
                  File(widget.product.productImagePath!),
                  width: 80,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              )
            else
              Hero(
                tag: widget.product.productId,
                child: Image.asset(widget.product.productUrl!, width: 150),
              ),
            const SizedBox(height: 5),
            const Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.product.productName),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  '\$${widget.product.productPrice}',
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 30,
                  height: 30,
                  padding: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
