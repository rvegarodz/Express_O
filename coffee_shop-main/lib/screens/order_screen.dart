import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final User? user;
  final String time;
  final List<dynamic> orderData;

  const OrderScreen(
      {required this.user, required this.time, required this.orderData});

  Future<int> calculateSubTotal(List<dynamic> orderData) async {
    int subTotal = 0;

    for (final itemData in orderData) {
      final itemPrice = int.tryParse(itemData[1].toString()) ?? 0;
      subTotal += itemPrice;
    }

    // Simulate an asynchronous operation with a delay
    await Future.delayed(const Duration(seconds: 1));

    return subTotal;
  }

  @override
  Widget build(BuildContext context) {
    const double screenPadding = 20.0;
    const double itemPadding = 15.0;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 42, 45, 47),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(
            top: screenPadding,
            left: screenPadding,
            right: screenPadding,
          ),
          child: ListView(children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: itemPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white.withOpacity(0.5),
                      size: 35,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: itemPadding),
              child: const Text(
                "Order Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: itemPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Container(
                    height: 200, // Set a fixed height for the list
                    child: ListView.builder(
                      itemCount: orderData.length,
                      itemBuilder: (BuildContext context, int index) {
                        final itemData = orderData[index];
                        final itemName = itemData[0].toString();
                        final itemPrice =
                            int.tryParse(itemData[1].toString()) ?? 0;
                        return buildOrderItem(itemName, itemPrice);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 100, // Set a fixed height for the list
                    child: FutureBuilder<int>(
                      future: calculateSubTotal(orderData),
                      builder:
                          (BuildContext context, AsyncSnapshot<int> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error calculating subTotal: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final subTotal = snapshot.data!;
                          return buildOrderSubTotal(subTotal);
                        } else {
                          return const Text('No data available');
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Order Confirmed'),
                              content:
                                  const Text('Your order has been placed.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 80,
                        ),
                        child: const Text(
                          'Confirm Order',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFE57734),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        )));
  }

  Widget buildOrderItem(String itemName, int itemPrice) {
    final int price = itemPrice;
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(
              itemName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            "\$ $price",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOrderSubTotal(num subTotal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(
              "Subtotal",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            "\$ $subTotal",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
