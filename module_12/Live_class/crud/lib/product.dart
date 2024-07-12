class Product {
  final String id;
  final String productName;
  final String productCode;
  final String image;
  final String quantity;
  final String unitprice;
  final String totalPrice;

  Product(
      {required this.id,
      required this.productName,
      required this.productCode,
      required this.image,
      required this.quantity,
      required this.unitprice,
      required this.totalPrice});
}
