import 'package:hive_flutter/hive_flutter.dart';

part 'category.g.dart';

@HiveType(typeId: 2)
enum Categories {
  @HiveField(0)
  watch,

  @HiveField(1)
  laptop,

  @HiveField(2)
  tv,

  @HiveField(3)
  headphone,

  @HiveField(4)
  macBook,
}

@HiveType(typeId: 3)
class Category {
  const Category(
    this.title,
    this.category,
    this.categoryUrl,
  );

  @HiveField(0)
  final String title;
  @HiveField(1)
  final Categories category;
  @HiveField(2)
  final String categoryUrl;
}
