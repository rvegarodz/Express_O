import 'package:coffee_shop/db/firebase_services.dart';
import 'package:coffee_shop/screens/order_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeBottomBar extends StatelessWidget {
  final List<dynamic> orderList;
  final User user;
  final String time;

  const HomeBottomBar({
    Key? key,
    required this.orderList,
    required this.user,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xFF212325),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            color: Color(0xFFE57734),
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () async {
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
                                orderData: orderList,
                                orderList: [],
                              )));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('No items selected.'),
                      backgroundColor: Color(0xFFE57734),
                    ),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                child: Text(
                  "Checkout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
