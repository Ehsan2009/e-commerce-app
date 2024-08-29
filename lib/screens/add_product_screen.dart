import 'dart:io';

import 'package:e_commerce_app/components/user_image_picker.dart';
import 'package:e_commerce_app/data/category.dart';
import 'package:e_commerce_app/data/product.dart';
import 'package:e_commerce_app/models/category.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var _enteredName = '';
  var _enteredPrice = '';
  var _enteredDetail = '';
  File? _selectedImage;
  var _selectedCategory = categories[Categories.watch];
  final _form = GlobalKey<FormState>();

  void saveProduct() {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();

      products.add(
        Product(
          productImagePath: _selectedImage!.path,
          productName: _enteredName,
          productPrice: int.parse(_enteredPrice),
          details: _enteredDetail,
          category: _selectedCategory!.category,
        ),
      );

      _form.currentState!.reset();
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
          'Add Product',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upload the Product Image',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: UserImagePicker(
                    onPickImage: (pickedImage) {
                      _selectedImage = pickedImage;
                    },
                    source: ImageSource.gallery,
                    boxRadius: 80,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Product Name',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length < 4) {
                        return 'please enter at least 4 characters.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredName = value!;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Product Price',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length < 4) {
                        return 'please enter at least 4 characters.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredPrice = value!;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Product Detail',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    minLines: 8,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length < 4) {
                        return 'please enter at least 4 characters.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredDetail = value!;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Product Detail',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    value: _selectedCategory,
                    items: [
                      for (final category in categories.entries)
                        DropdownMenuItem(
                          value: category.value,
                          child: Text(category.value.title),
                        ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: saveProduct,
                    child: const Text('Add Product'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
