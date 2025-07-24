import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cart/model/cart_item.dart';
import '../../cart/provider/cart_provider.dart';
import '../../home/model/restaurant.dart';
import '../provider/food_item_provider.dart';

class RestaurantDetailsPage extends ConsumerWidget {
  final Restaurant restaurant;

  const RestaurantDetailsPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodItemsAsync = ref.watch(foodItemProvider(restaurant.id));
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(title: Text(restaurant.name)),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.network(restaurant.imageUrl, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              restaurant.description,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: foodItemsAsync.when(
              data:
                  (items) => ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];

                      final quantity = cartItems.firstWhere(
                            (element) => element.item.id == item.id,
                        orElse: () => CartItem(item: item, quantity: 0),
                      ).quantity;

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: Image.network(
                            item.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.name),
                          subtitle: Text('₹${item.price.toStringAsFixed(2)}'),
                          trailing: quantity == 0 ? IconButton(
                            onPressed: () {
                              ref.read(cartProvider.notifier).addToCart(item);
                            },
                            icon: const Icon(Icons.add_shopping_cart),
                          ) : SizedBox(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () => ref.read(cartProvider.notifier).decreaseQuantity(item.id),
                                ),
                                Text(quantity.toString()),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => ref.read(cartProvider.notifier).increaseQuantity(item.id),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
