import 'package:crud/rest_api/rest_client.dart';
import 'package:crud/style/style.dart';
import 'package:flutter/material.dart';

class ProductCreate extends StatefulWidget {
  const ProductCreate({super.key});

  @override
  State<ProductCreate> createState() => _ProductCreateState();
}

class _ProductCreateState extends State<ProductCreate> {
  Map<String, String> formValues = {
    "Img": "",
    "ProductCode": "",
    "ProductName": "",
    "Qty": "",
    "TotalPrice": "",
    "UnitPrice": ""
  };

  bool loading = false;

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
      await productCreateRequest(formValues);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Product"),
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
                          decoration: appInputDecoration('Product Name'),
                          onChanged: (textValue) {
                            InputOnChange('ProductName', textValue);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: appInputDecoration('Product Code '),
                          onChanged: (textValue) {
                            InputOnChange('ProductCode', textValue);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: appInputDecoration('Product Image'),
                          onChanged: (textValue) {
                            InputOnChange('Img', textValue);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: appInputDecoration('Unit Price'),
                          onChanged: (textValue) {
                            InputOnChange('UnitPrice', textValue);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: appInputDecoration('Total Price'),
                          onChanged: (textValue) {
                            InputOnChange('TotalPrice', textValue);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        appDropDownStyle(DropdownButton(
                          value: formValues['Qty'],
                          items:  [
                             DropdownMenuItem(
                              child: Text('Select Qt'),
                              value: '',
                            ),
                            DropdownMenuItem(
                              child: Text('1 pcs'),
                              value: '1 pcs',
                            ),
                            DropdownMenuItem(
                              child: Text('2 pcs'),
                              value: '2 pcs',
                            ),
                            DropdownMenuItem(
                              child: Text('3 pcs'),
                              value: '3 pcs',
                            ),
                            DropdownMenuItem(
                              child: Text('4 pcs'),
                              value: '4 pcs',
                            ),
                          ],
                          onChanged: (textValue) {
                            InputOnChange('Qty', textValue);
                          },
                          isExpanded: true,
                          underline: Container(),
                        )),
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
