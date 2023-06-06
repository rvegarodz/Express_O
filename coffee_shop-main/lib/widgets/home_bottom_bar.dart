import 'package:coffee_shop/db/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeBottomBar extends StatelessWidget {
  final List<dynamic> orderList;
  final User user;
  final String time;

  const HomeBottomBar(
      {Key? key,
      required this.orderList,
      required this.user,
      required this.time})
      : super(key: key);

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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 80),
          Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  try {
                    FirebaseService.addOrders(user.uid, orderList, time);
                    FirebaseService.fetchData(user.uid, time);
                    print(orderList);
                  } catch (e) {
                    print("Error adding orders: $e");
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  child: Text("Order",
                      style: TextStyle(
                        color: Color(0xFFE57734),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      )),
                ),
              )),
          SizedBox(height: 80),
          Material(
              color: Color(0xFFE57734),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  try {
                    print(orderList);
                    FirebaseService.addOrders(user.uid, orderList, time);
                    orderList.clear();
                    print(orderList);
                  } catch (e) {
                    print("Error adding orders: $e");
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  child: Text("Pay",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      )),
                ),
              ))
        ],
      ),
    );
  }
}
