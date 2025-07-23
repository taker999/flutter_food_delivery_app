import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/firebase/restaurant_service.dart';
import '../model/restaurant_model.dart';

final restaurantServiceProvider = Provider((ref) => RestaurantService());

final restaurantListProvider = FutureProvider<List<Restaurant>>((ref) {
  final restaurantService = ref.read(restaurantServiceProvider);
  return restaurantService.getAllRestaurants();
});
