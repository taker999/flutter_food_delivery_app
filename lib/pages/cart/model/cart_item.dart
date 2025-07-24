import '../../restaurant_details/model/food_item.dart';

class CartItem {
  final FoodItem item;
  int quantity;

  CartItem({
    required this.item,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'item': item.toMap(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      item: FoodItem.fromMap(map['item']),
      quantity: map['quantity'],
    );
  }

  double get totalPrice => item.price * quantity;
}
