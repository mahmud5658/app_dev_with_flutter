import 'category.dart';

class CategoryList {
  String? msg;
  List<Category>? categories;

  CategoryList({this.msg, this.categories});

  CategoryList.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      categories = <Category>[];
      json['data'].forEach((v) {
        categories!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.categories != null) {
      data['data'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
