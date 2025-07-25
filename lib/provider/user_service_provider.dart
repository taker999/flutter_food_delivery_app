import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/firebase/user_service.dart';

final userServiceProvider = Provider((ref) => UserService());