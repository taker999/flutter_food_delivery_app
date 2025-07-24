class FoodItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory FoodItem.fromMap(Map<String, dynamic> data) {
    return FoodItem(
      id: data['id'],
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

}
