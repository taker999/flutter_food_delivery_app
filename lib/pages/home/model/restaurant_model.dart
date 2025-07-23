import 'food_item_model.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final List<FoodItem> foodItems;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    this.foodItems = const [],
  });

  factory Restaurant.fromMap(String id, Map<String, dynamic> data) {
    final itemsData = data['foodItems'] as List<dynamic>?;

    final foodItems = itemsData != null
        ? itemsData.map((item) {
      final map = Map<String, dynamic>.from(item);
      return FoodItem.fromMap(map['id'] ?? '', map);
    }).toList()
        : <FoodItem>[];

    return Restaurant(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      rating: (data['rating'] ?? 0).toDouble(),
      foodItems: foodItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'foodItems': foodItems.map((f) => f.toMap()).toList(),
    };
  }
}
