import 'package:daily_basket_sellers/blocs/auth_bloc.dart';
import 'package:daily_basket_sellers/views/category_dashboard_view.dart';
import 'package:daily_basket_sellers/views/customer_dashboard_view.dart';
import 'package:daily_basket_sellers/views/order_dashboard_view.dart';
import 'package:daily_basket_sellers/views/order_details_view.dart';
import 'package:daily_basket_sellers/views/orders_list_view.dart';
import 'package:daily_basket_sellers/views/payment_dashboard_view.dart';
import 'package:daily_basket_sellers/views/payment_list_view.dart';
import 'package:daily_basket_sellers/views/product_dashboard_view.dart';
import 'package:daily_basket_sellers/views/sign_in_view.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  AuthorizationBloc _authorizationBloc = AuthorizationBloc();

  List<Text> navbarViewTitle = [
    Text('Orders'),
    Text('Payments'),
    Text('Customers'),
  ];

  List<Widget> navbarViews = [
    OrderDashboardView(),
    PaymentDashboardView(),
    CustomerDashboardView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: navbarViewTitle[_selectedIndex],
        centerTitle: false,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'DM',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blue[300],
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.6),
                ),
              ),
              accountName: Text(
                'Digvijay Mhasaye',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  letterSpacing: 0.8,
                ),
              ),
              accountEmail: Text('digvijaymhasaye8@gmail.com'),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersListView()),
                );
              },
              child: ListTile(
                title: Text(
                  'Orders',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentListView()),
                );
              },
              child: ListTile(
                title: Text(
                  'Payments',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Customers',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryDashboardView()),
                );
              },
              child: ListTile(
                title: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDashboardView()),
                );
              },
              child: ListTile(
                title: Text(
                  'Products',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 1.0,
            ),
            ListTile(
              title: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await _authorizationBloc.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInView()));
              },
              child: ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.grey[600],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            title: Text('Orders'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            title: Text('Payments'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            title: Text('Customers'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
      body: navbarViews[_selectedIndex],
    );
  }
}
