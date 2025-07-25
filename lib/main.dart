import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/cart/provider/cart_provider.dart';
import 'pages/home/provider/restaurant_provider.dart';
import 'pages/login/view/login_page.dart';
import 'pages/main/provider/bottom_nav_index_provider.dart';
import 'pages/main/view/main_page.dart';
import 'pages/profile/provider/current_user_provider.dart';
import 'provider/auth_state_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

void invalidateUserScopedProviders(WidgetRef ref) {
  ref.invalidate(currentUserProvider);
  ref.invalidate(cartProvider);
  ref.invalidate(restaurantProvider);
  ref.invalidate(bottomNavIndexProvider);
}


class _MyAppState extends ConsumerState<MyApp> {
  User? _previousUser;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    authState.whenData((user) {
      if (user?.uid != _previousUser?.uid) {
        _previousUser = user;

        // Invalidate all user-specific providers on user change
        invalidateUserScopedProviders(ref);
      }
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery App',
      home: authState.when(
        data: (user) {
          if (user != null) {
            return const MainPage();
          } else {
            return const LoginPage();
          }
        },
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (err, _) => Scaffold(
          body: Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}

