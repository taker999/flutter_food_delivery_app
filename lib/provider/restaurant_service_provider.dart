import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/firebase/restaurant_service.dart';

final restaurantServiceProvider = Provider((ref) => RestaurantService());