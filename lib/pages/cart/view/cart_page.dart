import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/widgets/button/custom_elevated_button.dart';
import '../../order_success/view/order_success_page.dart';
import '../model/cart_item.dart';
import '../provider/cart_provider.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
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
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(item.item.imageUrl),
                              ),
                              title: Text(
                                item.item.name,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
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
                                          () => ref
                                              .read(cartProvider.notifier)
                                              .decreaseQuantity(item.item.id),
                                    ),
                                    Text(
                                      item.quantity.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed:
                                          () => ref
                                              .read(cartProvider.notifier)
                                              .increaseQuantity(item.item.id),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border(
                        top: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            'Total: ₹${ref.read(cartProvider.notifier).totalPrice.toStringAsFixed(2)}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // place order button
                        CustomElevatedButton(
                          buttonColor: Colors.grey.shade600,
                          icon: Icons.shopping_cart,
                          text: 'Place Order',
                          textColor: Colors.white,
                          onPressed: () {
                            List<CartItem> orderedItems = cartItems;
                            ref.read(cartProvider.notifier).clearCart();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => OrderSuccessPage(
                                      orderedItems: orderedItems,
                                    ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
