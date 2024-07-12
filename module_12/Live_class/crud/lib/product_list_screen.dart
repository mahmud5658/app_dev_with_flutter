import 'dart:convert';

import 'package:crud/add_product.dart';
import 'package:crud/product_model.dart';
import 'package:crud/update_product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool _getProductListInProgress = false;

  List<ProductModel> productList = [];

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: RefreshIndicator(
        onRefresh: _getProductList,
        child: Visibility(
          visible: _getProductListInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.separated(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return _buildProductItem(productList[index]);
            },
            separatorBuilder: (_, __) => const Divider(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddProductScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildProductItem(ProductModel product) {
    return ListTile(
      title: Text(product.productName??'Unknown'),
      leading: Image.network(
        product.image??'Unknown',
        height: 60,
        width: 60,
      ),
      subtitle: Wrap(
        spacing: 16,
        children: [
          Text('Unit Price: ${product.unitprice}'),
          Text('Quantity: ${product.quantity}'),
          Text('Total Price: ${product.totalPrice}'),
        ],
      ),
      trailing: Wrap(children: [
        IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateProductScreen(
                            product: product,
                          )));

              if (result == true) {
                _getProductList();
              }
            },
            icon: const Icon(Icons.edit)),
        IconButton(
            onPressed: () {
              _showConfirmationDialog(product.id!);
            },
            icon: const Icon(Icons.delete_outline_sharp))
      ]),
    );
  }

  void _showConfirmationDialog(String productId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete'),
            content: const Text('Are you want to delete this product?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('cancel')),
              TextButton(
                  onPressed: () {
                    _deleteProduct(productId);
                    Navigator.pop(context);
                  },
                  child: const Text('Yes')),
            ],
          );
        });
  }

  Future<void> _getProductList() async {
    _getProductListInProgress = true;
    setState(() {});
    productList.clear();
    var postHeader = {"Content-Type": "application/json"};
    var url = Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct/');

    var response = await http.get(url, headers: postHeader);

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      var jsonproductList = decodedData['data'];
      for (Map<String, dynamic> json in jsonproductList) {
        ProductModel productModel = ProductModel.fromJson(json);
        productList.add(productModel);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Get Product list failed! Try again')));
    }
    _getProductListInProgress = false;
    setState(() {});
  }

  Future<void> _deleteProduct(String productId) async {
    _getProductListInProgress = true;
    setState(() {});
    var postHeader = {"Content-Type": "application/json"};
    var url = Uri.parse(
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/' + productId);

    var response = await http.get(url, headers: postHeader);

    if (response.statusCode == 200) {
      _getProductList();
    } else {
      _getProductListInProgress = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Delete product failed! Try again')));
    }
    _getProductListInProgress = false;
    setState(() {});
  }
}
