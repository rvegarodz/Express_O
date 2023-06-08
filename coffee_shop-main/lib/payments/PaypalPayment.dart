import 'dart:core';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'PaypalServices.dart';

class PaypalPayment extends StatefulWidget {
  final Function onFinish;

  PaypalPayment({required this.onFinish});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String checkoutUrl;
  late String executeUrl;
  late String accessToken;
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic,dynamic> defaultCurrency = {"symbol": "USD ", "decimalDigits": 2, "symbolBeforeTheNumber": true, "currency": "USD"};

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL= 'cancel.example.com';

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initPayment();
  }

  Future<void> _initPayment() async {
    try {
      accessToken = (await services.getAccessToken())!;

      final transactions = getOrderParams();
      final res = await services.createPaypalPayment(transactions, accessToken);
      if (res != null) {
        setState(() {
          checkoutUrl = res["approvalUrl"]!;
          executeUrl = res["executeUrl"]!;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('exception: '+e.toString());
      final snackBar = SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: 10),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      if (_scaffoldKey.currentState != null) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

    // checkout invoice details
    String totalAmount = '1.99';
    String subTotalAmount = '1.99';
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String userFirstName = 'Gulshan';
    String userLastName = 'Yadav';
    String addressCity = 'Delhi';
    String addressStreet = 'Mathura Road';
    String addressZipCode = '110014';
    String addressCountry = 'India';
    String addressState = 'Delhi';
    String addressPhoneNumber = '+919990119091';

    Map<String, dynamic> getOrderParams() {
  // Item details
  String itemName = 'iPhone X';
  String itemPrice = '1.99';
  int quantity = 1;

  // Currency details
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

 
  // Buyer details
  String userFirstName = 'Gulshan';
  String userLastName = 'Yadav';
  String addressCity = 'Delhi';
  String addressStreet = 'Mathura Road';
  String addressZipCode = '110014';
  String addressCountry = 'India';
  String addressState = 'Delhi';
  String addressPhoneNumber = '+919990119091';

  // Checkout invoice details
  String totalAmount = '1.99';
  String subTotalAmount = '1.99';
  String shippingCost = '0';
  int shippingDiscountCost = 0;

  List<dynamic> items = [
    {
      "name": itemName,
      "quantity": quantity,
      "price": itemPrice,
      "currency": defaultCurrency["currency"]
    }
  ];

  Map<String, dynamic> orderParams = {
    "intent": "sale",
    "payer": {"payment_method": "paypal"},
    "transactions": [
      {
        "amount": {
          "total": totalAmount,
          "currency": defaultCurrency["currency"],
          "details": {
            "subtotal": subTotalAmount,
            "shipping": shippingCost,
            "shipping_discount": (-1.0 * shippingDiscountCost).toString()
          }
        },
        "description": "The payment transaction description.",
        "payment_options": {"allowed_payment_method": "INSTANT_FUNDING_SOURCE"},
        "item_list": {}
      }
    ],
    "note_to_payer": "Contact us for any questions on your order.",
    "redirect_urls": {
      "return_url": returnURL,
      "cancel_url": cancelURL
    }
  };

  return orderParams;
}
  
@override
Widget build(BuildContext context) {
  if (_isLoading) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.black12,
        elevation: 0.0,
      ),
      body: Center(child: CircularProgressIndicator()),
    );
  } else if (checkoutUrl != null) {
    // Rest of the code...
    

  }

  // Default return statement
  return Scaffold(
    key: _scaffoldKey,
    appBar: AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Colors.black12,
      elevation: 0.0,
    ),
    body: Center(child: Text('Error initializing payment')),
  );
}
}