import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/auth_service_provider.dart';
import '../../../provider/user_service_provider.dart';
import '../model/app_user.dart';

final currentUserProvider = FutureProvider<AppUser?>((ref) async {
  final user = ref.read(authServiceProvider).currentUser;
  if (user == null) return null;

  final userService = ref.read(userServiceProvider);
  return await userService.getUserById(user.uid);
});