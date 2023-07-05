import 'package:coffee_shop/db/firebase_services.dart';
import 'package:coffee_shop/screens/order_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShoppingCartWidget extends StatelessWidget {
  final int cartItemCount;
  final List<dynamic> orderList;
  final User user;
  final String time;

  ShoppingCartWidget({
    required this.cartItemCount,
    required this.orderList,
    required this.user,
    required this.time,
  });

  void handleOrder(BuildContext context) async {
    try {
      print(orderList);
      await FirebaseService.addOrders(user.uid, orderList, time);
      print(orderList);
    } catch (e) {
      print("Error adding orders: $e");
    }
    if (orderList.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderScreen(
            user: user,
            time: time,
            orderData:
                orderList, // Pass an empty list as it's not available in the ShoppingCartWidget
            orderList: [], // Pass the orderList to the OrderScreen
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No items selected.'),
          backgroundColor: Color(0xFFE57734),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white.withOpacity(0.5),
            ),
            onPressed: () => handleOrder(context), // Call the common function
          ),
          Visibility(
            visible: cartItemCount > 0,
            child: Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                constraints: BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  cartItemCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
