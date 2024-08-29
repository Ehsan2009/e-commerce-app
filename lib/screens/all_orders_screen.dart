import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  List<Map<String, dynamic>> _paidUsers = [];
  var _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    _fetchPaidUsers();
  }

  Future<void> _fetchPaidUsers() async {
    try {
      // Query the payments collection
      final paymentsSnapshot =
          await FirebaseFirestore.instance.collection('payments').get();

      // Fetch user details for each payment document
      List<Map<String, dynamic>> fetchedUsers = [];
      for (var paymentDoc in paymentsSnapshot.docs) {
        var paymentData = paymentDoc.data();
        if (paymentData.containsKey('userId')) {
          fetchedUsers.add(paymentData);
        }
      }

      setState(() {
        _paidUsers = fetchedUsers;
      });
    } catch (e) {
      print('Error fetching paid users: $e');
    }
  }

  void acceptProduct(String productId) async {
    try {
      setState(() {
        _isAuthenticating = true;
      });

      final querySnapshot = await FirebaseFirestore.instance
          .collection('payments')
          .where('productId', isEqualTo: productId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming productId is unique, so we delete the first matched document
        var documentId = querySnapshot.docs.first.id;
        await FirebaseFirestore.instance
            .collection('payments')
            .doc(documentId)
            .delete();

        setState(() {
          _paidUsers.removeWhere((user) => user['productId'] == productId);
          _isAuthenticating = false;
        });
      }
    } catch (e) {
      print('Error updating product status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.go('/admin_panel_screen');
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(
          'All Orders',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _paidUsers.length,
        itemBuilder: (ctx, index) {
          return ProductCard(
            onPressed: () {
              acceptProduct(_paidUsers[index]['productId'] as String);
            },
            productName: _paidUsers[index]['productName'] as String,
            productPrice: _paidUsers[index]['productPrice'] as int,
            imageUrl: _paidUsers[index]['imageUrl'] as String,
            userName: _paidUsers[index]['userName'] as String,
            userEmail: _paidUsers[index]['email'] as String,
            isAdminOrderScreen: true,
            isAuthenticating: _isAuthenticating,
          );
        },
      ),
    );
  }
}
