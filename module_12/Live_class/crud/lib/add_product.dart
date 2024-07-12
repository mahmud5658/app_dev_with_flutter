import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _unitPriceEditingController =
      TextEditingController();
  final TextEditingController _quantityEditingController =
      TextEditingController();
  final TextEditingController _totalPriceEditingController =
      TextEditingController();
  final TextEditingController _imageEditingController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                  decoration:
                      InputDecoration(hintText: 'Name', labelText: 'Name'),
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
                  keyboardType: TextInputType.number,
                  controller: _unitPriceEditingController,
                  decoration: InputDecoration(
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
                  decoration: InputDecoration(
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
                  decoration: InputDecoration(
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
                  decoration:
                      InputDecoration(hintText: 'Image', labelText: 'Image'),
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
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: const Text('Submit'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameEditingController.dispose();
    _unitPriceEditingController.dispose();
    _imageEditingController.dispose();
    _totalPriceEditingController.dispose();
    _quantityEditingController.dispose();
  }
}
