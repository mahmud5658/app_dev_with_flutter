import 'package:crafty_bay/data/model/wished_product.dart';

class WishList {
  String? msg;
  List<WishedProduct>? products;

  WishList({this.msg, this.products});

  WishList.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      products = <WishedProduct>[];
      json['data'].forEach((v) {
        products!.add(new WishedProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.products != null) {
      data['data'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



