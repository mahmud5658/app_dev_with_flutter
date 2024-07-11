import 'package:crud/rest_api/rest_client.dart';
import 'package:crud/style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductGridViewScreen extends StatefulWidget {
  const ProductGridViewScreen({super.key});

  @override
  State<ProductGridViewScreen> createState() => _ProductGridViewScreenState();
}

class _ProductGridViewScreenState extends State<ProductGridViewScreen> {
  List productList = [];
  bool loading = true;
  @override
  void initState() {
    callData();
    super.initState();
  }

  callData() async {
    var data = await productGridViewRequest();
    setState(() {
      productList = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Stack(
        children: [
          screenBackground(context),
          Container(
              child: loading
                  ? (Center(
                      child: CircularProgressIndicator(),
                    ))
                  : RefreshIndicator(
                      onRefresh: ()async {
                        await callData();
                      },
                      child: GridView.builder(
                          itemCount: productList.length,
                          gridDelegate: productGridViewStyle(),
                          itemBuilder: (context, index) {
                            return Card(
                              // clipBehavior: ,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      child: Image.network(
                                    productList[index]['Img'],
                                    fit: BoxFit.fill,
                                  )),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(productList[index]['ProductName']),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text('Price : ' +
                                            productList[index]['UnitPrice'] +
                                            'BDT'),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            OutlinedButton(
                                                onPressed: () {},
                                                child: Icon(
                                                  CupertinoIcons
                                                      .ellipsis_vertical_circle,
                                                  size: 18,
                                                  color: colorGreen,
                                                )),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            OutlinedButton(
                                                onPressed: () {},
                                                child: const Icon(
                                                  CupertinoIcons.delete,
                                                  size: 18,
                                                  color: colorRed,
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ))
        ],
      ),
    );
  }
}
