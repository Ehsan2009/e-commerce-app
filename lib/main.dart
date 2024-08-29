import 'package:e_commerce_app/config/app_router.dart';
import 'package:e_commerce_app/firebase_options.dart';
import 'package:e_commerce_app/models/category.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = 'pk_test_51PffZwKex58DMrkDFYbnhiPJ6qNNCCeP8hgUWp2PghtenjEmh1l741wQeRCrkycJ6Gj6F3npAS4iQtvblXfrRPEt00C84ElbJJ';
  
  // initialize hive
  await Hive.initFlutter();

  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(CategoriesAdapter());
  Hive.registerAdapter(CategoryAdapter());

  // open the box
  await Hive.openBox<Product>('products');
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
