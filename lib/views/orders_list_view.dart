import 'package:daily_basket_sellers/blocs/order_bloc.dart';
import 'package:daily_basket_sellers/views/order_details_view.dart';
import 'package:flutter/material.dart';

class OrdersListView extends StatefulWidget {
  @override
  _OrdersListViewState createState() => _OrdersListViewState();
}

class _OrdersListViewState extends State<OrdersListView> {
  CustomerOrderBloc _customerOrderBloc = CustomerOrderBloc();
  String _sortBy = 'created_at';
  String _sortOrder = 'desc';
  ScrollController controller = new ScrollController();
  bool isLoading = false;
  int pageNo = 0;
  int pageSize = 15;
  List items = [];
  int totalOrders = 0;

  getCount() async {
    var stats = await _customerOrderBloc.getOrderStats(false);
    totalOrders = stats['total_orders'];
  }

  Future _loadData() async {
    // perform fetching data delay
    var ordersList = await _customerOrderBloc.getAllOrdersList(
        _sortBy, _sortOrder, null, pageNo += 1, pageSize, false);

    // update data and loading status
    setState(() {
      if (ordersList.length > 0) {
        totalOrders -= items.length;
        items.addAll(ordersList);
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getCount();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            if (totalOrders > 0) {
              _loadData();
              // start loading data
              setState(() {
                isLoading = true;
              });
            }
          }
          return null;
        },
        child: ListView.builder(
            padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            itemCount: items.length,
            controller: controller,
            itemBuilder: (context, index) {
              if (items.length == 0) {
                return Center(
                  child: Text('No pending orders.'),
                );
              }
              var splitOrderCreatedAt = items[index]['created_at'].split('T');
              List splitOrderCreatedAtTime = splitOrderCreatedAt[1].split(':');
              String orderCreatedAtDate = splitOrderCreatedAt[0];
              String orderCreatedAtTime =
                  '${splitOrderCreatedAtTime[0]}:${splitOrderCreatedAtTime[1]}';
              var orderCreatedAt = '$orderCreatedAtDate $orderCreatedAtTime';
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderDetailsView(
                              items[index]['customer_id'], items[index]['id'])),
                    );
                  },
                  title: Text(
                    '${items[index]['customer']['first_name']} ${items[index]['customer']['last_name']}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      letterSpacing: 0.5,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Placed on $orderCreatedAt',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  leading: items[index]['status'] == 0 ||
                          items[index]['status'] == 1 ||
                          items[index]['status'] == 2
                      ? Icon(
                          Icons.access_time,
                          color: Colors.blue,
                        )
                      : (items[index]['status'] == 3
                          ? Icon(
                              Icons.local_shipping,
                              color: Colors.orange,
                            )
                          : (items[index]['status'] == 4
                              ? Icon(
                                  Icons.done,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ))),
                ),
              );
            }),
      ),
    );
  }
}
