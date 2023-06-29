import 'dart:convert';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

/// Function that make a POST request before launching new tab
Future<void> createPaymentIntentAndRedirect(int total) async {
  final urlPost = Uri.parse(
      'https://rewardsprogram-production.up.railway.app/create-payment-intent');

  final urlPayment =
      Uri.parse('https://rewardsprogram-production.up.railway.app/');
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
    final clientSecret = jsonData['clientSecret'];

    // Launch the payment URL in new tab
    await launchUrl(urlPayment);

    // Check if the payment URL
    retrievePaymentIntentWithRetry(clientSecret);
  } else {
    throw Exception('Failed to create payment intent');
  }
}

Future<void> retrievePaymentIntentWithRetry(String clientSecret) async {
  // replace this with get to /config
  final apiSecretKey =
      'pk_test_51NId2JJEeTzUc4tCQq2NrZosWy3oJfu6ZfpTHQCbsxc2h2dNOQRWuN3gq46e9mmANKvQeiGwPT2e77mWXqBgFkzG009VTFGCZX';

  final maxRetryAttempts = 6;
  final retryDelay = Duration(seconds: 10);

  var retryAttempts = 0;

  while (retryAttempts < maxRetryAttempts) {
    final response = await http.get(
      Uri.parse('https://api.stripe.com/v1/payment_intents/$clientSecret'),
      headers: {
        'Authorization': 'Bearer $apiSecretKey',
      },
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
