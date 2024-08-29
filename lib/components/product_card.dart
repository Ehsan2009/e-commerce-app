import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    this.product,
    this.productName,
    this.productPrice,
    this.onPressed,
    this.imageUrl,
    this.userName,
    this.userEmail,
    this.isAuthenticating,
    required this.isAdminOrderScreen,
  });

  final void Function()? onPressed;
  final Product? product;
  final String? productName;
  final int? productPrice;
  final String? imageUrl;
  final String? userName;
  final String? userEmail;
  final bool? isAuthenticating;
  final bool isAdminOrderScreen;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  String message = 'on the way';

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(left: 24, right: 24, top: 16),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Row(
          children: [
            if (widget.isAdminOrderScreen)
              Container(
                width: 110,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(widget.imageUrl!),
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              )
            else
              Image.asset(
                widget.product!.productUrl!,
                width: 120,
              ),
            if (widget.isAdminOrderScreen) const SizedBox(width: 16),
            if (widget.isAdminOrderScreen)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${widget.userName}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Email: ${widget.userEmail}',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    Text(
                      widget.productName!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${widget.productPrice}',
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onPressed != null
                          ? () {
                              widget.onPressed!();
                              setState(() {
                                message = 'accepted';
                              });
                            }
                          : null,
                      child: Container(
                        width: 100,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: widget.isAuthenticating!
                            ? const Center(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : const Text(
                                'Done',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              )
            else
              const Spacer(),
            if (widget.isAdminOrderScreen == false)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product!.productName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${widget.product!.productPrice}',
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Status: $message',
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
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
