import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../pages/profile/model/app_user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<AppUser?> getUserById(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return AppUser.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      log('Error fetching user: $e');
      return null;
    }
  }
}
