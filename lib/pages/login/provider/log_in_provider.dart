import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../provider/auth_service_provider.dart';

import '../../../services/firebase/auth_service.dart';

class SignInController extends AsyncNotifier<void> {
  late final AuthService _authService;

  @override
  FutureOr<void> build() {
    _authService = ref.read(authServiceProvider);
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();

    try {
      final success = await _authService.signIn(email, password);
      if (!success) {
        throw Exception('Invalid email or password');
      }
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final logInProvider = AsyncNotifierProvider<SignInController, void>(SignInController.new);

