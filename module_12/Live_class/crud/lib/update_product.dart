import 'dart:convert';


import 'package:crud/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateProductScreen extends StatefulWidget {
  final ProductModel product;
  const UpdateProductScreen({super.key, required this.product});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
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

  @override
  void initState() {
    super.initState();
    _nameEditingController.text = widget.product.productName??'';
    _productCodeEditingController.text = widget.product.productCode??'';
    _unitPriceEditingController.text = widget.product.unitprice??'';
    _quantityEditingController.text = widget.product.quantity??'';
    _totalPriceEditingController.text = widget.product.totalPrice??'';
    _imageEditingController.text = widget.product.image??'';
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool updateProductInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
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
                    visible: updateProductInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          if (updateProductInProgress == true) {
                            Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (_formKey.currentState!.validate()) {
                            updateProduct();
                          }
                        },
                        child: const Text('Update')))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateProduct() async {
    updateProductInProgress = true;
    setState(() {});
    Map<String, dynamic> inputData = {
      "Img": _imageEditingController.text.trim(),
      "ProductCode": _productCodeEditingController.text,
      "ProductName": _nameEditingController.text,
      "Qty": _quantityEditingController.text,
      "TotalPrice": _totalPriceEditingController.text,
      "UnitPrice": _unitPriceEditingController.text,
    };
    var postHeader = {"Content-Type": "application/json"};
    var postBody = jsonEncode(inputData);
    var url = Uri.parse('https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}');
    var response = await http.post(url, headers: postHeader, body: postBody);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Product has been updated')));
      Navigator.pop(context,true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product update failed! try again')));
      updateProductInProgress = false;
      setState(() {
        
      });
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
