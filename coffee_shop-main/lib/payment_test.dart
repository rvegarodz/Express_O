import 'package:flutter/material.dart';
import 'package:paypal_sdk/paypal_sdk.dart';

class PayPalIntegrationPage extends StatefulWidget {
  @override
  _PayPalIntegrationPageState createState() => _PayPalIntegrationPageState();
}

class _PayPalIntegrationPageState extends State<PayPalIntegrationPage> {
  final String clientId = 'YOUR_CLIENT_ID';
  final String secret = 'YOUR_SECRET';

  void startPayment() async {
    PayPalConfiguration configuration = PayPalConfiguration(
      clientId: clientId,
      secret: secret,
      sandboxMode: true,
    );
    PayPalService.setup(configuration);

    PayPalPayment payment = PayPalPayment(
      amount: '10.00',
      currency: 'USD',
      shortDescription: 'Payment for services',
    );
    String paymentResult = await PayPalService.startPayment(payment);

    PayPalPaymentDetails paymentDetails =
        await PayPalService.verifyPayment(paymentResult);
    if (paymentDetails.status == PayPalPaymentStatus.completed) {
      // Payment was successful, proceed with further actions
      print('Payment completed!');
    } else {
      // Payment was not completed or encountered an error
      print('Payment error: ${paymentDetails.error}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PayPal Integration'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: startPayment,
          child: Text('Make Payment'),
        ),
      ),
    );
  }
}
