import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/screens/add_product_screen.dart';
import 'package:e_commerce_app/screens/admin_panel_screen.dart';
import 'package:e_commerce_app/screens/all_orders_screen.dart';
import 'package:e_commerce_app/screens/auth_screen.dart';
import 'package:e_commerce_app/screens/cart_screen.dart';
import 'package:e_commerce_app/screens/category_screen.dart';
import 'package:e_commerce_app/screens/details_screen.dart';
import 'package:e_commerce_app/screens/home_screen.dart';
import 'package:e_commerce_app/screens/introduction_screen.dart';
import 'package:e_commerce_app/screens/profile_screen.dart';
import 'package:e_commerce_app/screens/splash_screen.dart';
import 'package:e_commerce_app/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/introduction_screen',
      builder: (context, state) => const IntroductionScreen(),
    ),
    GoRoute(
      path: '/auth_screen',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/details_screen',
      builder: (context, state) {
        final product = state.extra as Product;
        return DetailsScreen(product: product);
      },
    ),
    GoRoute(
      path: '/admin_panel_screen',
      builder: (context, state) => const AdminPanelScreen(),
    ),
    GoRoute(
      path: '/add_product_screen',
      builder: (context, state) => const AddProductScreen(),
    ),
    GoRoute(
      path: '/all_orders_screen',
      builder: (context, state) => const AllOrdersScreen(),
    ),
    GoRoute(
      path: '/category_screen',
      builder: (context, state) {
        final products = state.extra as List<Product>;
        return CategoryScreen(products: products);
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return TabsScreen(navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey,
          routes: [
            GoRoute(
              path: '/home_screen',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/cart_screen',
              builder: (context, state) => const CartScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile_screen',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
