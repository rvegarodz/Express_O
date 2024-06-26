import 'dart:convert';
import 'dart:async';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:coffee_shop/db/firebase_services.dart';

/// Function that make a POST request before launching new tab
Future<void> createPaymentIntentAndRedirect(
    int total, String userId, List<dynamic> items, String time) async {
  final urlPost =
      Uri.parse('https://payment.up.railway.app/create-payment-intent');

  final urlPayment = Uri.parse('https://payment.up.railway.app/');
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
    final jsonData = json.decode(response.body);
    final paymentIntentID = jsonData['paymentIntentID'];

    // Push order information to database
    await FirebaseService.addOrders(
        userId, items, total, time, paymentIntentID);
    // Open the payment URL in the same tab/window
    window.location.href = urlPayment.toString();

    // Check if the payment process was successful,
    // to trigger other actions as display order to Business Owner Screen:
    // |--------------------------------------------------------|
    // |  retrievePaymentIntentWithRetry(paymentIntentID);      |
    // |--------------------------------------------------------|
  } else {
    throw Exception('Failed to create payment intent');
  }
}

// At the moment is not in use.
Future<void> retrievePaymentIntentWithRetry(String paymentIntentID) async {
  final maxRetryAttempts = 10;
  final retryDelay = Duration(seconds: 40);
  var retryAttempts = 0;

  while (retryAttempts < maxRetryAttempts) {
    final response = await http.get(
      Uri.parse(
          'https://payment.up.railway.app/payment-intent?id=$paymentIntentID'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final status = jsonData['status'];

      if (status == 'succeeded') {
        print('Payment intent succeeded!');
        // Handle the successful payment intent here

        break; // Exit the loop if successful
      } else {
        print('Payment intent status: $status');
        // Handle the payment intent status as needed
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }

    retryAttempts++;

    if (retryAttempts < maxRetryAttempts) {
      await Future.delayed(retryDelay);
      print('Retrying...');
    } else {
      print('Exceeded maximum retry attempts.');
    }
  }
}
