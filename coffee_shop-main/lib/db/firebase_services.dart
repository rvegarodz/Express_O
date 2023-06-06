import 'package:coffee_shop/widgets/date_time.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static Future<void> addOrders(
      String userId, List<dynamic> items, String time) async {
    String docName = orderDocName(userId, time);
    final List<dynamic> orderItems = items.map((item) => item).toList();
    final userOrdersRef =
        await FirebaseFirestore.instanceFor(app: Firebase.app())
            .collection('orders');
    final myDocRef = userOrdersRef.doc(docName);
    await myDocRef.set({
      'userId': userId,
      'time': time,
    });
    for (int i = 0; i < orderItems.length; i++) {
      myDocRef.update({'item$i': orderItems[i]});
    }
    ;
  }

  static Future<void> addDescription(
      String userId, List<dynamic> items, String time) async {
    String docName = orderDocName(userId, time);
    final List<dynamic> orderItems = items.map((item) => item).toList();
    final userOrdersRef =
        await FirebaseFirestore.instanceFor(app: Firebase.app())
            .collection('description');
    final myDocRef = userOrdersRef.doc(docName);
    await myDocRef.set({
      'userId': userId,
      'time': time,
    });
    for (int i = 0; i < orderItems.length; i++) {
      myDocRef.update({'item$i': orderItems[i]});
    }
    ;
  }

  static Future<void> getOrders(String userId, String time) async {
    final docId = orderDocName(userId, time);
    final docOrderRef = await FirebaseFirestore.instanceFor(app: Firebase.app())
        .collection('orders')
        .doc(docId);

    docOrderRef.get().then((doc) {
      if (doc.exists) {
        // The document exists, you can access its data using the data() method
        print(doc.data());
      } else {
        print("Document does not exist");
      }
    }).catchError((error) {
      print("Error getting document: $error");
    });
  }

  static Future<void> addUser(User user) async {
    final userRef = await FirebaseFirestore.instanceFor(app: Firebase.app())
        .collection('users')
        .doc(user.uid);
    await userRef.set({
      'userId': user.uid,
      'metadata': user.metadata,
      'email': user.email,
      'points': 1,
    });
  }
}
