import 'dart:convert';

class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final double? offerPercentage;
  final String? description;
  final List<String>? colors;
  final List<String>? sizes;
  final List<String> images;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.offerPercentage,
    this.description,
    this.colors,
    this.sizes,
    required this.images,
  });

  Product copyWith({
    String? id,
    String? name,
    String? category,
    double? price,
    double? offerPercentage,
    String? description,
    List<String>? colors,
    List<String>? sizes,
    List<String>? images,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      offerPercentage: offerPercentage ?? this.offerPercentage,
      description: description ?? this.description,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      images: images ?? this.images,
    );
  }

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: json['price'].toDouble(),
      offerPercentage: json['offerPercentage']?.toDouble(),
      description: json['description'],
      colors: (json['colors'] as List?)?.map((e) => e.toString()).toList(),
      sizes: (json['sizes'] as List?)?.map((e) => e.toString()).toList(),
      images: (json['images'] as List).map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
  return {
    'id': id,
    'name': name,
    'category': category,
    'price': price,
    'offerPercentage': offerPercentage,
    'description': description,
    'colors': colors,
    'sizes': sizes,
    'images': images,
  };
}
}






