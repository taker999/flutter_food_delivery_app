import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../provider/auth_service_provider.dart';
import '../../restaurant_details/model/food_item.dart';
import '../model/cart_item.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier(this.uid) : super([]) {
    _loadCartFromPrefs();
  }

  final String uid;

  Future<void> _saveCartToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = state.map((item) => jsonEncode(item.toMap())).toList();
    await prefs.setStringList('cart_$uid', cartJson);
  }

  Future<void> _loadCartFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getStringList('cart_$uid') ?? [];
    state =
        cartJson
            .map((jsonStr) => CartItem.fromMap(jsonDecode(jsonStr)))
            .toList();
  }

  void addToCart(FoodItem item) {
    final index = state.indexWhere((element) => element.item.id == item.id);
    if (index == -1) {
      state = [...state, CartItem(item: item, quantity: 1)];
    } else {
      final updated = [...state];
      updated[index] = CartItem(
        item: item,
        quantity: updated[index].quantity + 1,
      );
      state = updated;
    }
    _saveCartToPrefs();
  }

  void increaseQuantity(String itemId) {
    final updated =
        state.map((cartItem) {
          if (cartItem.item.id == itemId) {
            return CartItem(
              item: cartItem.item,
              quantity: cartItem.quantity + 1,
            );
          }
          return cartItem;
        }).toList();
    state = updated;
    _saveCartToPrefs();
  }

  void decreaseQuantity(String itemId) {
    final updated =
        state
            .where((cartItem) {
              if (cartItem.item.id == itemId && cartItem.quantity > 1) {
                return true;
              } else if (cartItem.item.id != itemId) {
                return true;
              }
              return false;
            })
            .map((cartItem) {
              if (cartItem.item.id == itemId) {
                return CartItem(
                  item: cartItem.item,
                  quantity: cartItem.quantity - 1,
                );
              }
              return cartItem;
            })
            .toList();

    state = updated;
    _saveCartToPrefs();
  }

  double get totalPrice => state.fold(0, (sum, item) => sum + item.totalPrice);

  void clearCart() {
    state = [];
    _saveCartToPrefs();
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(ref.read(authServiceProvider).currentUser!.uid),
);
