import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/restaurant_service_provider.dart';
import '../model/restaurant.dart';

final restaurantProvider = FutureProvider<List<Restaurant>>((ref) {
  final restaurantService = ref.read(restaurantServiceProvider);
  return restaurantService.getAllRestaurants();
});
