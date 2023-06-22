import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class OrderScreen extends StatelessWidget {
  final User? user;
  final String time;
  final List<dynamic> orderData;

  const OrderScreen(
      {required this.user, required this.time, required this.orderData});

  /// FUNCTION THAT CALCULATE VALUES FOR THE BUILDER
  Future<List<double>> calculateSubTotal(List<dynamic> orderData) async {
    double subTotal = 0.00;
    double taxRate = 0.115;
    double taxTotal = 0.00;
    double total = 0;

    // Iteration through order for calculate subTotal
    for (final itemData in orderData) {
      final itemPrice = int.tryParse(itemData[1].toString()) ?? 0;
      subTotal += itemPrice;
    }

    // Calculate and format values to return
    total = subTotal + (subTotal * taxRate);
    subTotal = double.parse(subTotal.toStringAsFixed(2));
    total = double.parse(total.toStringAsFixed(2));
    taxTotal = total - subTotal;
    taxTotal = double.parse(taxTotal.toStringAsFixed(2));

    // Simulate an asynchronous operation with a delay
    await Future.delayed(const Duration(seconds: 1));

    return [subTotal, taxRate, taxTotal, total];
  }

  /// Function that format total for createPaymentIntentAndRedirect()
  int formatTotal(double total) {
    // Multiply by 100 and round to the nearest whole number
    int totalInteger = (total * 100).round();

    // Check if the total has three digits
    if (totalInteger >= 100 && totalInteger < 1000) {
      // Add a leading zero
      totalInteger = int.parse('0${totalInteger}');
    }

    // Return the formatted total
    return totalInteger;
  }

  /// Function that make a POST request before launching new tab
  Future<void> createPaymentIntentAndRedirect(int total) async {
    final urlPost = Uri.parse(
        'https://wondrous-profiterole-f56042.netlify.app/create-payment-intent');
    final urlPayment =
        Uri.parse('https://wondrous-profiterole-f56042.netlify.app/');
    final payload = {
      'amount': total,
      'currency': 'USD',
    };

    // POST request to stripe
    final response = await http.post(
      urlPost,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(payload),
    );

    // Verifying POST Status
    print('Response status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      // Launch the payment URL in new tab
      await launchUrl(urlPayment);
    } else {
      throw Exception('Failed to create payment intent');
    }
  }

  @override
  Widget build(BuildContext context) {
    const double screenPadding = 20.0;
    const double itemPadding = 15.0;
    Future<List<double>> orderList = calculateSubTotal(orderData);

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
                    height: 400, // Set a fixed height for the list
                    child: ListView.builder(
                      itemCount: orderData.length,
                      itemBuilder: (BuildContext context, int index) {
                        final itemData = orderData[index];
                        return buildOrderItem(itemData);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 140, // Set a fixed height for the list
                    child: FutureBuilder<List<double>>(
                      future: calculateSubTotal(orderData),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<double>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(16.0), // Add padding
                              child: CircularProgressIndicator(),
                            ),
                          );
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
                      onPressed: () async {
                        final totalDouble = await orderList;
                        final totalStr = formatTotal(totalDouble[3]);
                        print(totalStr);
                        await createPaymentIntentAndRedirect(totalStr);
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

  Widget buildOrderItem(List<dynamic> orderData) {
    final String itemName = orderData[0];
    final int itemPrice = int.tryParse(orderData[1].toString()) ?? 0;
    final String itemSize = orderData.length > 2 ? orderData[2] : "-";
    final String itemSugar = orderData.length > 3 ? orderData[3] : "-";
    final String itemMilk = orderData.length > 4 ? orderData[4] : "-";

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF212325),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                  "\$ ${itemPrice}.00",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    "Size: $itemSize",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    itemSugar,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  itemMilk,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildOrderSubTotal(List<double> subTotal) {
    String taxRate = (subTotal[1] * 100).toStringAsFixed(1);

    return Container(
      height: 300,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF212325),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                  "\$ ${subTotal[0]}.00",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    "Tax Rate ($taxRate%)",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "\$ ${subTotal[2]}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    "Total",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "\$ ${subTotal[3]}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
