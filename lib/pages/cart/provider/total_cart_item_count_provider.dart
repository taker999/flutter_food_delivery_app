import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cart_provider.dart';

final totalCartItemCountProvider = Provider<int>((ref) {
  final cartItems = ref.watch(cartProvider);
  return cartItems.fold(0, (sum, item) => sum + item.quantity);
});
