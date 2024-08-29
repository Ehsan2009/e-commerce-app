import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:go_router/go_router.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  void onTap(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: CurvedNavigationBar(
        onTap: onTap,
        index: widget.navigationShell.currentIndex,
        color: Colors.black,
        backgroundColor: Colors.grey[100]!,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.person_outline,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
