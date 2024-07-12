import 'package:crud/add_product.dart';
import 'package:crud/update_product.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.separated(
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildProductItem();
        },
        separatorBuilder: (_, __) => const Divider(),
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

  ListTile _buildProductItem() {
    return ListTile(
      title: const Text('Product Name'),
      leading: Image.network(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvhmmSlUAEdUZU1HybEKBHz9ShQPtkvuW9t9bm7fvT7jIObHNVtjC3FAckdQ&s',
        height: 60,
      ),
      subtitle: const Wrap(
        spacing: 16,
        children: [
          Text('Unit Price: 100'),
          Text('Quantity: 100'),
          Text('Total Price: 100'),
        ],
      ),
      trailing: Wrap(children: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductUpdateScreen()));
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
            title: Text('Delete'),
            content: Text('Are you want to delete this product?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('cancel')),
              TextButton(onPressed: () {}, child: Text('Yes')),
            ],
          );
        });
  }
}
