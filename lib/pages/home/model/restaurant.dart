class Restaurant {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
  });

  factory Restaurant.fromMap(Map<String, dynamic> data) {
    return Restaurant(
      id: data['id'],
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      rating: (data['rating'] ?? 0).toDouble(),
    );
  }

}