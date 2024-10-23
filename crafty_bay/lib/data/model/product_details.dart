import 'package:crafty_bay/data/model/product_details_data.dart';

class ProductDetails {
  String? msg;
  List<ProductDetailsData>? productData;

  ProductDetails({this.msg, this.productData});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      productData = <ProductDetailsData>[];
      json['data'].forEach((v) {
        productData!.add(new ProductDetailsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.productData != null) {
      data['data'] = this.productData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}