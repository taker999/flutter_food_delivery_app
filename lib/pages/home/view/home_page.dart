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
        title: const Text(
          'Restaurants',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Stack(
                children: [
                  SizedBox(
                      width: 30,
                      height: 50,
                      child: Icon(Icons.shopping_cart, color: Colors.grey[600])),

                  Positioned(
                    right: 0,
                    child: Text(
                      totalCartItemCount.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
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
                  leading: Hero(
                    tag: restaurant.id,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(restaurant.imageUrl),
                    ),
                  ),
                  title: Text(
                    restaurant.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
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
