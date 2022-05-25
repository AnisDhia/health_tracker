class Product {
  final String name, upc;
  final String? imageUrl, description;
  final Map<String, dynamic> nutrients;

  Product({
    required this.upc,
    required this.name,
    required this.nutrients,
    this.description,
    this.imageUrl
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      upc: json['code'].toString(),
      name: json['product']['generic_name'] ?? json['product']['product_name'],
      description: json['product']['product_name'] as String,
      nutrients: json['product']['nutriments'],
      imageUrl: json['product']['image_url'] ?? 'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg'
    );
  }
}
