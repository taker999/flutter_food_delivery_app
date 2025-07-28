import 'package:cloud_firestore/cloud_firestore.dart';
import '../../pages/restaurant_details/model/food_item.dart';
import '../../pages/home/model/restaurant.dart';

class RestaurantService {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Restaurant>> getAllRestaurants() async {
    final restaurantSnapshots =
        await _firestore.collection('restaurants').get();

    List<Restaurant> restaurants = [];

    for (final doc in restaurantSnapshots.docs) {
      final data = doc.data();

      restaurants.add(Restaurant.fromMap(data));
    }

    return restaurants;
  }

  Future<List<FoodItem>> getFoodItems(String restaurantId) async {
    final snapshot =
        await _firestore
            .collection('restaurants')
            .doc(restaurantId)
            .collection('foodItems')
            .get();

    return snapshot.docs.map((doc) {
      return FoodItem.fromMap(doc.data());
    }).toList();
  }
}
