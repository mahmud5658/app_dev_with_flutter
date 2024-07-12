class ProductModel {
  String? id;
  String? productName;
  String? productCode;
  String? image;
  String? quantity;
  String? unitprice;
  String? totalPrice;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    productName = json['ProductName'];
    productCode = json['ProductCode'];
    image = json['Img'];
    quantity = json['Qty'];
    unitprice = json['UnitPrice'];
    totalPrice = json['TotalPrice'];
  }
}
