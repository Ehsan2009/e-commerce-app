import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final _productsBox = Hive.box<Product>('products');
  Map<String, dynamic>? paymentIntent;
  var _isAuthenticating = false;
  bool? _isDelivering;
  String? _userImageUrl;
  String? _userName;
  String? _userEmail;

  @override
  void initState() {
    super.initState();
    _isDelivering = _productsBox.containsKey(widget.product.productId);
    _loadData();
  }

  Future<void> _loadData() async {
    final user = FirebaseAuth.instance.currentUser;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    setState(() {
      _userImageUrl = doc['imageUrl'];
      _userName = doc['userName'];
      _userEmail = doc['email'];
    });
  }

  void makePayment(String amount) async {
    try {
      setState(() {
        _isAuthenticating = true;
      });
      paymentIntent = await createPaymentIntent(amount, 'INR');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent?['client_secret'],
        style: ThemeMode.dark,
        merchantDisplayName: 'Ehsan',
      ));

      await displayPaymentSheet();

      setState(() {
        _isAuthenticating = false;
      });
    } catch (e) {
      print('$e');
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        _productsBox.put(
          widget.product.productId,
          widget.product,
        );

        await FirebaseFirestore.instance.collection('payments').add({
          'userId': user!.uid,
          'userName': _userName,
          'email': _userEmail,
          'imageUrl': _userImageUrl,
          'status': 'On the way',
          'productId': widget.product.productId,
          'productName': widget.product.productName,
          'productPrice': widget.product.productPrice,
          'timestamp': DateTime.now(),
        });

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            content: Container(
              width: 350,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.task_alt_outlined,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 6),
                  Text('You successfully ordered ${widget.product.productName}'),
                ],
              ),
            ),
          ),
        );

        setState(() {
          _isDelivering = true;
        });
      });
      paymentIntent = null;
    } catch (e) {
      print('failed');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51PffZwKex58DMrkDjie2QPcOdIFOBgY1OBs7KMqWBcRCYwTCkGwUUC1rjHx4T4Cn2k4c3W2bseOIUYTaj1FxRzNy00Ft000wzq',
            'Content_Type': 'application/x-www-form-urlendcoded',
          });
      return json.decode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  calculateAmount(String amount) {
    final calculateAmount = int.parse(amount) * 100;
    return calculateAmount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 450,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            decoration: BoxDecoration(
              color: Colors.brown[200],
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 231, 168, 84),
                  Color.fromARGB(255, 109, 67, 13),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Stack(
              children: [
                if (widget.product.productImagePath != null)
                  Align(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: widget.product.productId,
                      child: Image.file(
                        File(widget.product.productImagePath!),
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  Hero(
                    tag: widget.product.productId,
                    child: Image.asset(
                      widget.product.productUrl!,
                      width: 600,
                    ),
                  ),
                IconButton(
                  onPressed: () {
                    context.go('/home_screen');
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.product.productName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${widget.product.productPrice}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.product.details,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 30),
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        if (_isDelivering!) {
                          return;
                        }
                        makePayment(widget.product.productPrice.toString());
                      },
                      child: Container(
                        width: 300,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                              _isDelivering! ? Colors.black : Colors.redAccent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: _isAuthenticating
                            ? const CircularProgressIndicator()
                            : Text(
                                _isDelivering! ? 'Is delivering...' : 'Buy Now',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
