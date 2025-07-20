
class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final double? offerPercentage;
  final String? description;
  final List<int>? colors;
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
    List<int>? colors,
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

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      price: map['price'].toDouble(),
      offerPercentage: map['offerPercentage']?.toDouble(),
      description: map['description'],
      colors: (map['colors'] as List?)?.map((e) => e as int).toList(),
      sizes: (map['sizes'] as List?)?.map((e) => e.toString()).toList(),
      images: (map['images'] as List).map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toMap() {
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






