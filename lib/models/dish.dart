class Dish {
  final String id;
  final String name;
  final double price;
  final String description;
  final List<String> includes;
  final bool isAvailable;
  final String category; // 'Breakfast', 'Lunch', 'Dinner'

  Dish({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.includes,
    required this.isAvailable,
    required this.category,
  });

  // Copy constructor to make edits easier
  Dish copyWith({
    String? id,
    String? name,
    double? price,
    String? description,
    List<String>? includes,
    bool? isAvailable,
    String? category,
  }) {
    return Dish(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      includes: includes ?? this.includes,
      isAvailable: isAvailable ?? this.isAvailable,
      category: category ?? this.category,
    );
  }

  // Convert to Map for Firebase/JSON compatibility
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'includes': includes,
      'isAvailable': isAvailable,
      'category': category,
    };
  }

  // Create from Map
  factory Dish.fromMap(Map<String, dynamic> map) {
    return Dish(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      description: map['description'] ?? '',
      includes: List<String>.from(map['includes'] ?? []),
      isAvailable: map['isAvailable'] ?? true,
      category: map['category'] ?? 'Breakfast',
    );
  }
}
