class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String thumbnail;
  final List<String> images;
  final List<String> tags;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.thumbnail,
    required this.images,
    required this.tags,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description',
      category: json['category'] ?? 'Unknown',
      price: (json['price'] ?? 0).toDouble(),
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      brand: json['brand'] ?? 'Premium Brand',
      thumbnail: json['thumbnail'] ?? '',
      images: List<String>.from(json['images'] ?? const []),
      tags: List<String>.from(json['tags'] ?? const []),
    );
  }

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  String get discountText => '-${discountPercentage.toStringAsFixed(0)}%';

  bool get isAvailable => stock > 0;

  String get heroImage => images.isNotEmpty ? images.first : thumbnail;

  String get shortCategory => category.replaceAll('-', ' ');
}
