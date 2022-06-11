class Product {
  final String name, upc;
  final String? imageUrl, description, servingQuantity, servingSize;
  final Map<String, dynamic> nutrients;

  Product(
      {required this.upc,
      required this.name,
      required this.nutrients,
      this.description,
      this.imageUrl,
      this.servingQuantity,
      this.servingSize});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      upc: json['code'].toString(),
      name: json['product']['product_name'] ??
          json['product']['generic_name'] ??
          '',
      description: json['product']['generic_name'] ?? '',
      nutrients: json['product']['nutriments'],
      imageUrl: json['product']['image_url'] ??
          'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg',
      servingQuantity: json['serving_quantity'],
      servingSize: json['serving_size'],
    );
  }
}
