import 'package:e_commerce_app/models/category.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'product.g.dart';

var uuid = const Uuid();

@HiveType(typeId: 0)
class Product {
  Product({
    String? productId,
     this.productUrl,
     this.productImagePath,
    required this.productName,
    required this.productPrice,
    required this.details,
    required this.category,
  }) : productId = productId ?? uuid.v4();

  @HiveField(0)
  final String productId;
  @HiveField(1)
  final String? productUrl;
  @HiveField(2)
  final String? productImagePath;
  @HiveField(3)
  final String productName;
  @HiveField(4)
  final int productPrice;
  @HiveField(5)
  final String details;
  @HiveField(6)
  final Categories category;
}
