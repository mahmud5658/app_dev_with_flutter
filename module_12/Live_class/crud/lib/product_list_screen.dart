import 'dart:convert';

import 'package:crud/add_product.dart';
import 'package:crud/product.dart';
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

  List<Product> productList = [];

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
      body: Visibility(
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

  Widget _buildProductItem(Product product) {
    return ListTile(
      title:  Text(product.productName),
      leading: Image.network(
       product.image,height: 60,width: 60,
      ),
      subtitle:  Wrap(
        spacing: 16,
        children: [
          Text('Uinit Price: '+product.unitprice),
          Text('Quantity: '+product.quantity),
          Text('Total Price: '+product.totalPrice),
        ],
      ),
      trailing: Wrap(children: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductUpdateScreen()));
            },
            icon: const Icon(Icons.edit)),
        IconButton(
            onPressed: () {
              _showConfirmationDialog();
            },
            icon: const Icon(Icons.delete_outline_sharp))
      ]),
    );
  }

  void _showConfirmationDialog() {
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
              TextButton(onPressed: () {}, child: const Text('Yes')),
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

    print(response.statusCode);

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      var  jsonproductList = decodedData['data'];
      for (Map<String, dynamic> p in jsonproductList) {
        Product product = Product(
            id: p['_d'] ?? '',
            productName: p['ProductName'] ?? 'Unknown',
            productCode: p['ProductCode'] ?? 'Unknown',
            image: p['Img'] ?? 'Unknown',
            quantity: p['Qty'] ?? 'Unknown',
            unitprice: p['UnitPrice'] ?? 'Unknown',
            totalPrice: p['TotalPrice'] ?? 'Unknown');
        productList.add(product);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Get Product list failed! Try again')));
    }
    _getProductListInProgress = false;
    setState(() {
      
    });
  }
}


