import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'product_card.dart';
import 'firebase_services.dart';

class HomePage extends StatelessWidget {
  final User user;
  final List<String> orderList = [];

  HomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String userId = user.uid;
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine the number of products to show in a row
    int crossAxisCount;
    if (screenWidth < 600) {
      crossAxisCount = 1; // Small screens: show one product per row
    } else if (screenWidth < 1200) {
      crossAxisCount = 2; // Medium screens: show two products per row
    } else {
      crossAxisCount = 3; // Large screens: show three products per row
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Shop'),
      ),
      body: GridView.count(
        crossAxisCount: crossAxisCount,
        childAspectRatio:
            0.8, // Adjust as needed to change the product card aspect ratio
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        padding: const EdgeInsets.all(16),
        children: [
          ProductCard(
              name: 'Espresso',
              description: '2 shots',
              price: 2.99,
              onPressed: () {
                orderList.add('Espresso');
              }),
          ProductCard(
              name: 'Cortado',
              description: '2 shot with equal parts steamed milk',
              price: 3.50,
              onPressed: () {
                orderList.add('Cortado');
              }),
          ProductCard(
              name: 'Latte',
              description: '2 shots with milk',
              price: 2.99,
              onPressed: () {
                orderList.add('Latte');
              }),
          ProductCard(
            name: 'Cappuccino',
            description: '1 shot with steamed milk and foam',
            price: 3.50,
            onPressed: () {
              orderList.add('Cappuccino');
            },
          ),
          ProductCard(
            name: 'Mocha',
            description: '1 shot with chocolate and milk',
            price: 4.00,
            onPressed: () {
              orderList.add('Mocha');
            },
          ),
          ProductCard(
            name: 'Iced Coffee',
            description: 'Cold coffee with ice',
            price: 3.00,
            onPressed: () {
              orderList.add('Iced Coffee');
            },
          ),
          ProductCard(
              name: 'Water',
              description: 'Water Bottle',
              price: 1.50,
              onPressed: () {
                orderList.add('Water');
              }),
          ProductCard(
              name: 'Tea',
              description: 'Variety of tea flavors',
              price: 2.00,
              onPressed: () {
                orderList.add('Tea');
              }),
          // Add more products here
          if (orderList.isNotEmpty)
            SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(orderList[index]),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseService.addOrders(userId, orderList);
          orderList.clear();
        },
        child: const Icon(Icons.add),
      ),
      persistentFooterButtons: [
        if (orderList.isNotEmpty)
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(orderList[index]),
              ),
            ),
          ),
      ],
    );
  }
}
