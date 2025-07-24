import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../order_success/view/order_success_page.dart';
import '../model/cart_item.dart';
import '../provider/cart_provider.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final total = cartNotifier.totalPrice;

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body:
          cartItems.isEmpty
              ? const Center(child: Text('Your cart is empty'))
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(item.item.imageUrl),
                          ),
                          title: Text(item.item.name),
                          subtitle: Text(
                            '₹${item.item.price.toStringAsFixed(2)}',
                          ),
                          trailing: SizedBox(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed:
                                      () => cartNotifier.decreaseQuantity(
                                        item.item.id,
                                      ),
                                ),
                                Text('${item.quantity}'),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed:
                                      () => cartNotifier.increaseQuantity(
                                        item.item.id,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Total: ₹${total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // You can trigger Firestore order save here
                            List<CartItem> orderedItems = cartItems;
                            cartNotifier.clearCart();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => OrderSuccessPage(
                                      orderedItems: orderedItems,
                                    ),
                              ),
                            );
                            // Navigator.pop(context);
                          },
                          child: const Text('Place Order'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
