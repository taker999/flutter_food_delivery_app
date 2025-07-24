import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/pages/cart/view/cart_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cart/provider/total_cart_item_count_provider.dart';
import '../../restaurant_details/view/restaurant_details_page.dart';
import '../provider/restaurant_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantAsync = ref.watch(restaurantProvider);
    final totalCartItemCount = ref.watch(totalCartItemCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              Text(totalCartItemCount.toString()),
            ],
          ),
        ],
      ),
      body: restaurantAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data:
            (restaurants) => ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(restaurant.imageUrl),
                  ),
                  title: Text(restaurant.name),
                  subtitle: Text(restaurant.description),
                  onTap: () {
                    // Navigate to Restaurant Details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) =>
                                RestaurantDetailsPage(restaurant: restaurant),
                      ),
                    );
                  },
                );
              },
            ),
      ),
    );
  }
}
