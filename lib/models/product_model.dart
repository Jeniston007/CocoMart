import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? discountPrice;
  final String categoryId;
  final List<String> images;
  final int stock;
  final bool isFeatured;
  final bool isPopular;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    required this.categoryId,
    required this.images,
    required this.stock,
    this.isFeatured = false,
    this.isPopular = false,
  });

  factory Product.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;
    return Product(
      id: document.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      discountPrice: data['discountPrice'] != null
          ? (data['discountPrice']).toDouble()
          : null,
      categoryId: data['categoryId'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      stock: data['stock'] ?? 0,
      isFeatured: data['isFeatured'] ?? false,
      isPopular: data['isPopular'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'discountPrice': discountPrice,
      'categoryId': categoryId,
      'images': images,
      'stock': stock,
      'isFeatured': isFeatured,
      'isPopular': isPopular,
    };
  }
}
