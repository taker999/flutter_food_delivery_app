import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/auth_service_provider.dart';
import '../../../utils/widgets/button/custom_elevated_button.dart';
import '../provider/current_user_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('User not found'));
          }

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Column(
                children: [
                  // Profile Picture
                  SizedBox(
                    width: 100,
                    child:
                        user.profileImageUrl.isNotEmpty
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(user.profileImageUrl),
                            )
                            : null,
                  ),

                  const SizedBox(height: 20),

                  const Divider(),

                  // Name
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Name:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(user.name, style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 16),

                        // Email
                        const Text(
                          'Email:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(user.email, style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),

                  const Divider(),

                  const Spacer(),

                  // logout button
                  CustomElevatedButton(
                    buttonColor: Colors.red.shade400,
                    icon: Icons.logout,
                    text: 'Log Out',
                    textColor: Colors.white,
                    onPressed: () async {
                      await ref.read(authServiceProvider).signOut();
                    },
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
