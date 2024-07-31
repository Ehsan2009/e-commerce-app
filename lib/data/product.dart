import 'package:e_commerce_app/models/category.dart';
import 'package:e_commerce_app/models/product.dart';

List<Product> products = [
  Product(
    productId: 'a1',
    productUrl: 'assets/images/headphone2.png',
    productName: 'Headphone',
    productPrice: 100,
    details:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua Egestas purus viverra accumsan in nisl nisi Arcu cursus vitae congue mauris rhoncus aenean vel elit scelerisque',
    category:  Categories.headphone,
  ),
  Product(
    productId: 'a2',
    productUrl: 'assets/images/watch2.png',
    productName: 'Apple Watch',
    productPrice: 300,
    details:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua Egestas purus viverra accumsan in nisl nisi Arcu cursus vitae congue mauris rhoncus aenean vel elit scelerisque',
    category: Categories.watch,
  ),
  Product(
    productId: 'a3',
    productUrl: 'assets/images/laptop2.png',
    productName: 'Laptop',
    productPrice: 1000,
    details:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua Egestas purus viverra accumsan in nisl nisi Arcu cursus vitae congue mauris rhoncus aenean vel elit scelerisque',
    category: Categories.laptop,
  ),
];
