import 'package:coffee_shop/widgets/items_widget.dart';
import 'package:coffee_shop/widgets/home_bottom_bar.dart';
import 'package:coffee_shop/widgets/phone_items-widget.dart';
import 'package:coffee_shop/widgets/date_time.dart';
import 'package:coffee_shop/widgets/shopping_cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/sort_rounded.dart';

class HomeScreen extends StatefulWidget {
  final User? user;

  final List<String> orderList = [];

  HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late User user;
  late int cartItemCount = 0;
  List<dynamic> orderList = [];
  String time = orderTime();

  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    user = widget.user!;
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void updateOrderList(List<dynamic> newOrderList) {
    setState(() {
      orderList = newOrderList;
      cartItemCount = orderList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String? userName = user.email;
    return Scaffold(
      drawer: MyDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 15),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: Icon(
                          Icons.sort_rounded,
                          color: Colors.white.withOpacity(0.5),
                          size: 35,
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {},
                        child: ShoppingCartWidget(
                          cartItemCount: cartItemCount,
                          orderList: [],
                          time: '',
                          user: user,
                        ))
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "It's a Great Day $userName",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TabBar(
                controller: _tabController,
                labelColor: Color(0xFFE57734),
                unselectedLabelColor: Colors.white.withOpacity(0.5),
                isScrollable: true,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3,
                    color: Color(0xFFE57734),
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 16),
                ),
                labelStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                labelPadding: EdgeInsets.symmetric(horizontal: 20),
                tabs: [
                  Tab(text: "Coffee"),
                ],
              ),
              SizedBox(height:10),
             Center(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (constraints.maxWidth >= 600) {
                    // Laptop or larger screen size
                    return ItemsWidget(
                      user: widget.user,
                      orderList: orderList,
                      updateOrderList: updateOrderList,
                      time: time,
                    );
                  } else {
                    // Phone or smaller screen size
                    return PhoneItemsWidget(
                      user: widget.user,
                      orderList: orderList,
                      updateOrderList: updateOrderList,
                      time: time,
                    );
                  }
                },
              ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          HomeBottomBar(user: user, orderList: orderList, time: time),
    );
  }
}
