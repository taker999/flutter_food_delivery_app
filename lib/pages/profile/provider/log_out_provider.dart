import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/auth_service_provider.dart';
import '../../../services/firebase/auth_service.dart';

final logOutProvider = AsyncNotifierProvider<SignOutController, void>(SignOutController.new);

class SignOutController extends AsyncNotifier<void> {
  late final AuthService _authService;

  @override
  FutureOr<void> build() {
    _authService = ref.read(authServiceProvider);
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    try {
      await _authService.signOut();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
