class Product {
  final String? id;
  final String name;
  final String description;
  final double price;
  final String image;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String?,
      name: json['name'] as String? ?? 'Produit sans nom',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] as String? ?? 'https://via.placeholder.com/150',
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'name': name,
      'description': description,
      'price': price,
      'image': image,
    };
    if (id != null) {
      map['id'] = id as Object;
    }
    return map;
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? image,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
    );
  }
}