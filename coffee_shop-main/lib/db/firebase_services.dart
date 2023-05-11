import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static Future<void> addOrders(String userId, List<String> orders) async {
    final userOrdersRef =
        FirebaseFirestore.instanceFor(app: Firebase.app()).collection('orders');
    await userOrdersRef.add({
      'userId': userId,
      'orders': orders,
    });
  }
}
