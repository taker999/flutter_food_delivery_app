import 'package:flutter/material.dart';

import '../../../utils/widgets/button/custom_elevated_button.dart';
import '../../cart/model/cart_item.dart';

class OrderSuccessPage extends StatelessWidget {
  final List<CartItem> orderedItems;

  const OrderSuccessPage({super.key, required this.orderedItems});

  @override
  Widget build(BuildContext context) {
    final double totalAmount = orderedItems.fold(
      0,
      (sum, item) => sum + item.item.price * item.quantity,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Summary',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 16),
            const Text(
              'Your order has been placed!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: orderedItems.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final item = orderedItems[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(item.item.imageUrl),
                    ),
                    title: Text(item.item.name),
                    subtitle: Text(
                      '${item.quantity} × ₹${item.item.price.toStringAsFixed(2)}',
                    ),
                    trailing: Text(
                      '₹${(item.item.price * item.quantity).toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '₹${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            CustomElevatedButton(
              buttonColor: Colors.grey.shade600,
              icon: Icons.home,
              text: 'Back to Home',
              textColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
