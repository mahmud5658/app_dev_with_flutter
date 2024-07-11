import 'package:crud/rest_api/rest_client.dart';
import 'package:crud/screen/product_grid_view.dart';
import 'package:crud/style/style.dart';
import 'package:flutter/material.dart';

class ProductUpdateScreen extends StatefulWidget {
  final Map productItem;
  const ProductUpdateScreen({super.key, required this.productItem});

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  Map<String, String> formValues = {
    "Img": "",
    "ProductCode": "",
    "ProductName": "",
    "Qty": "",
    "TotalPrice": "",
    "UnitPrice": ""
  };

  bool loading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      formValues.update('Img', (value) => widget.productItem['Img']);
      formValues.update(
          'ProductCode', (value) => widget.productItem['ProductCode']);
      formValues.update(
          'ProductName', (value) => widget.productItem['ProductName']);
      formValues.update('Qty', (value) => widget.productItem['Qty']);
      formValues.update(
          'TotalPrice', (value) => widget.productItem['TotalPrice']);
      formValues.update(
          'UnitPrice', (value) => widget.productItem['UnitPrice']);
    });
  }

  InputOnChange(mapKey, textValue) {
    setState(() {
      formValues.update(mapKey, (value) => textValue);
    });
  }

  formOnSubmit() async {
    if (formValues['Img']!.isEmpty) {
      errorToast('Image Link Required!');
    } else if (formValues['ProductCode']!.isEmpty) {
      errorToast('Product Code Required!');
    } else if (formValues['ProductName']!.isEmpty) {
      errorToast('Product Name Required!');
    } else if (formValues['Qty']!.isEmpty) {
      errorToast('Product Quantity Required!');
    } else if (formValues['TotalPrice']!.isEmpty) {
      errorToast('Total Price Required!');
    } else if (formValues['UnitPrice']!.isEmpty) {
      errorToast('Unit Price Required!');
    } else {
      // Data Rest API
      setState(() {
        loading = true;
      });
      await productUpdateRequest(formValues, widget.productItem['_id']);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => ProductGridViewScreen()),(Route route)=>false);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product"),
      ),
      body: Stack(
        children: [
          screenBackground(context),
          Container(
            child: loading
                ? (Center(
                    child: CircularProgressIndicator(),
                  ))
                : SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: formValues['ProductName'],
                          decoration: appInputDecoration('Product Name'),
                          onChanged: (textValue) {
                            InputOnChange('ProductName', textValue);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          initialValue: formValues['ProductCode'],
                          decoration: appInputDecoration('Product Code '),
                          onChanged: (textValue) {
                            InputOnChange('ProductCode', textValue);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          initialValue: formValues['Img'],
                          decoration: appInputDecoration('Product Image'),
                          onChanged: (textValue) {
                            InputOnChange('Img', textValue);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          initialValue: formValues['UnitPrice'],
                          decoration: appInputDecoration('Unit Price'),
                          onChanged: (textValue) {
                            InputOnChange('UnitPrice', textValue);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          initialValue: formValues['TotalPrice'],
                          decoration: appInputDecoration('Total Price'),
                          onChanged: (textValue) {
                            InputOnChange('TotalPrice', textValue);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          initialValue: formValues['Qty'],
                          decoration: appInputDecoration('Quantity'),
                          onChanged: (textValue) {
                            InputOnChange('TotalPrice', textValue);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: ElevatedButton(
                              style: appButtonStyle(),
                              onPressed: () {
                                formOnSubmit();
                              },
                              child: SuccessButtonChild('Submit')),
                        )
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
