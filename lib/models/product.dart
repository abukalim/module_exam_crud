class Product {
  String id;
  String img;
  String productCode;
  String productName;
  int qty;
  double totalPrice;
  double unitPrice;

  Product({
    required this.id,
    required this.img,
    required this.productCode,
    required this.productName,
    required this.qty,
    required this.totalPrice,
    required this.unitPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      img: json['Img'] ?? '',
      productCode: json['ProductCode'] ?? '',
      productName: json['ProductName'] ?? '',
      qty: int.tryParse(json['Qty'].toString()) ?? 0,
      totalPrice: double.tryParse(json['TotalPrice'].toString()) ?? 0.0,
      unitPrice: double.tryParse(json['UnitPrice'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Img': img,
      'ProductCode': productCode,
      'ProductName': productName,
      'Qty': qty,
      'TotalPrice': totalPrice,
      'UnitPrice': unitPrice,
    };
  }
}
