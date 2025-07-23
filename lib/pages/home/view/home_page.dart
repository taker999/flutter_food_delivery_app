import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/restaurant_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantAsync = ref.watch(restaurantListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Restaurants')),
      body: restaurantAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (restaurants) => ListView.builder(
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
              },
            );
          },
        ),
      ),
    );
  }
}
