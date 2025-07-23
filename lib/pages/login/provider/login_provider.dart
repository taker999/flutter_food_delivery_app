import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/firebase/auth_service.dart';

final authServiceProvider = Provider((ref) => AuthService());
