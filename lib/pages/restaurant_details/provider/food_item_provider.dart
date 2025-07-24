import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../provider/restaurant_service_provider.dart';
import '../model/food_item.dart';

final foodItemProvider = FutureProvider.family<List<FoodItem>, String>((ref, restaurantId) async {
  final restaurantService = ref.read(restaurantServiceProvider);
  return restaurantService.getFoodItems(restaurantId);
});
