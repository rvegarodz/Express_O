import 'package:coffee_shop/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

class Item {
  final String name;
  final String description;
  final int price;
  final String image;

  Item(
      {required this.name,
      required this.description,
      required this.price,
      required this.image});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
    );
  }
}

class ItemsWidget extends StatefulWidget {
  final User? user;
  final String time;
  final List<dynamic> orderList;
  final List<dynamic> orderItem = [];
  final Function(List<dynamic>) updateOrderList;

  ItemsWidget(
      {Key? key,
      required this.user,
      required this.time,
      required this.orderList,
      required this.updateOrderList})
      : super(key: key);

  @override
  _ItemsWidgetState createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  List<Item> items = [];
  List<dynamic> order = [];

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  void _addToOrder(Item item, Future<List<dynamic>?> selectedOptionsFuture) {
    selectedOptionsFuture.then((selectedOptions) {
      setState(() {
        List<dynamic> orderItem = [
          item.name,
          item.price,
          ...(selectedOptions?.expand((options) => options) ?? []),
        ];
        widget.orderList.add(orderItem);
        widget.updateOrderList(widget.orderList);
      });
    });
  }

  Future<void> loadItems() async {
    final jsonString =
        await rootBundle.loadString('assets/catalog/coffee_catalog.json');
    final jsonData = json.decode(jsonString);
    List<Item> items = [];

    for (var item in jsonData) {
      Item newItem = Item.fromJson(item);
      items.add(newItem);
    }

    setState(() {
      this.items = items;
      this.order = order;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3, //phone is 2
      shrinkWrap: true,
      childAspectRatio: 2,// for iphone(1 / 1.5),
      children: [
        for (int i = 0; i < items.length; i++)
          Container(
            height: 10,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
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
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Image.asset(
                    "images/${items[i].image}",
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          items[i].name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          items[i].description,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${items[i].price}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (items[i].name == 'Espresso' ||
                              items[i].name == 'Macchiato') {
                            List<List<String>> optionsList = [
                              ['4oz'],
                              ['Whole Milk', 'Oat Milk', 'Soy Milk'],
                              ['White Sugar', 'Black Sugar', 'Splenda'],
                            ];
                            var description = showCustomSnackBar(
                                context, optionsList, widget.user, widget.time);
                            _addToOrder(
                                items[i], description); // handle button press
                          } else {
                            List<List<String>> optionsList = [
                              ['6oz', '8oz'],
                              ['Whole Milk', 'Oat Milk', 'Soy Milk'],
                              ['White Sugar', 'Black Sugar', 'Splenda'],
                            ];
                            var description = showCustomSnackBar(
                                context, optionsList, widget.user, widget.time);
                            _addToOrder(
                                items[i], description); // handle button press
                          }
                          // handle button press
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xFFE57734),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            CupertinoIcons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
