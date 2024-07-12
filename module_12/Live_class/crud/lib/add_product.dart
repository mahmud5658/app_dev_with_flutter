import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _productCodeEditingController =
      TextEditingController();
  final TextEditingController _unitPriceEditingController =
      TextEditingController();
  final TextEditingController _quantityEditingController =
      TextEditingController();
  final TextEditingController _totalPriceEditingController =
      TextEditingController();
  final TextEditingController _imageEditingController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool addProductInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.name,
                  controller: _nameEditingController,
                  decoration: const InputDecoration(
                      hintText: 'Name', labelText: 'Name'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your Product Name';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  controller: _productCodeEditingController,
                  decoration: const InputDecoration(
                      hintText: 'Product Code', labelText: 'Product Code'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your Product Code';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _unitPriceEditingController,
                  decoration: const InputDecoration(
                      hintText: 'Unit Price', labelText: 'Unit Price'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your Product unit price';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _quantityEditingController,
                  decoration: const InputDecoration(
                      hintText: 'Quantity', labelText: 'Quantity'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your Product quantity';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _totalPriceEditingController,
                  decoration: const InputDecoration(
                      hintText: 'Total Price ', labelText: 'Total Price'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your Product total price';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _imageEditingController,
                  decoration: const InputDecoration(
                      hintText: 'Image', labelText: 'Image'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'paste your image url';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Visibility(
                    visible: addProductInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          if (addProductInProgress == true) {
                            Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (_formKey.currentState!.validate()) {
                            _addProduct();
                          }
                        },
                        child: const Text('Submit')))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addProduct() async {
    addProductInProgress = true;
    setState(() {});
    //step1: set uri
    const String addNewProductUrl =
        'https://crud.teamrabbil.com/api/v1/CreateProduct';
    //step2: prepare data

    Map<String, dynamic> inputData = {
      "Img": _imageEditingController.text.trim(),
      "ProductCode": _productCodeEditingController.text,
      "ProductName": _nameEditingController.text,
      "Qty": _quantityEditingController.text,
      "TotalPrice": _totalPriceEditingController.text,
      "UnitPrice": _unitPriceEditingController.text,
    };

    var postBody = jsonEncode(inputData);

    var postHeader = {"Content-Type": "application/json"};
// step3: parse
    Uri uri = Uri.parse(addNewProductUrl);
    //step4: send request
    var response = await http.post(
      uri,
      headers: postHeader,
      body: postBody,
    );
    print(response.statusCode);
    print(response.body);
    print(response.headers);
    addProductInProgress = false;
    setState(() {});

    if (response.statusCode == 200) {
      _nameEditingController.clear();
      _productCodeEditingController.clear();
      _unitPriceEditingController.clear();
      _imageEditingController.clear();
      _totalPriceEditingController.clear();
      _quantityEditingController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('New Product added')));
    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('add new product failed! try again')));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameEditingController.dispose();
    _productCodeEditingController.dispose();
    _unitPriceEditingController.dispose();
    _imageEditingController.dispose();
    _totalPriceEditingController.dispose();
    _quantityEditingController.dispose();
  }
}
