import 'package:coffee_shop/screens/order_screen.dart';
import 'package:flutter/material.dart';

class ShoppingCartWidget extends StatelessWidget {
  final int cartItemCount;

  ShoppingCartWidget({required this.cartItemCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Stack(
          children: [
            Icon(
              Icons.shopping_cart,
              color: Colors.white.withOpacity(0.5),
            ),
            Visibility(
              visible: cartItemCount > 0,
              child: Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors
                        .orange, // Set the desired background color for the circular background
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderScreen(),
            ),
          );
          // Handle shopping cart button press
        },
      ),
    );
  }
}
