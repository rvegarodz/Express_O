import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

Future<void> createPaymentIntentAndRedirect(int total) async {
  final urlPost = Uri.parse('http://localhost:4242/create-payment-intent');
  final urlPayment = Uri.parse('http://localhost:4242/');
  final payload = {
    'amount': total,
    'currency': 'USD',
  };
  // POST REQUEST TO STRIPE
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

// Function that create a new price for the product
Future<void> makePostRequestPrice(String price) async {
  var url = Uri.parse('https://api.stripe.com/v1/prices');
  var headers = {
    'Authorization':
        'Bearer sk_test_51NId2JJEeTzUc4tC79XYEn4W8WrQZcon0pIXnemXTLhsLx97E5SjKn5hmtJ931S44c3ssT4lwgG7LbU3XlAxIoDn00IsnISmFI',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  var body = {
    'unit_amount': price,
    'currency': 'usd',
    'product': 'prod_O4pR5OpJM2YFAn'
  };

  var response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    // Successful POST request
    var responseBody = jsonDecode(response.body);
    var id = responseBody['id'];
    print('Price ID: $id');
    updateEnvVariable(id);
  } else {
    // Error handling
    print('POST request failed with status: ${response.statusCode}');
  }
}

Future<void> updateEnvVariable(String value) async {
  final url = Uri.parse('https://api.netlify.com/api/v1');
  final accountId = 'express o';
  final key = 'PRICE'; // Name of the environment variable to update
  final token =
      'gwfKZk_mGNg2QNlww1qx2XWrGA80GwUr1GFzcPYXy6s'; // Replace with your Netlify API token

  final response = await http.put(
    Uri.parse('$url/accounts/$accountId/env/$key'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: '{"value": "$value"}',
  );

  if (response.statusCode == 200) {
    print('Environment variable updated successfully');
  } else {
    print('Failed to update environment variable');
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

// Function that create a new price for the product
Future<void> updatePriceEnv(String price) async {
  var url = Uri.parse('https://api.netlify.com/api/v1/');
  var headers = {
    'Authorization':
        'Bearer sk_test_51NId2JJEeTzUc4tC79XYEn4W8WrQZcon0pIXnemXTLhsLx97E5SjKn5hmtJ931S44c3ssT4lwgG7LbU3XlAxIoDn00IsnISmFI',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  var body = {
    'unit_amount': price,
    'currency': 'usd',
    'product': 'prod_O4pR5OpJM2YFAn'
  };

  var response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    // Successful POST request
    var responseBody = jsonDecode(response.body);
    var id = responseBody['id'];
    print('Price ID: $id');
  } else {
    // Error handling
    print('POST request failed with status: ${response.statusCode}');
  }
}
