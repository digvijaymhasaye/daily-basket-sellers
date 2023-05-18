import 'package:daily_basket_sellers/blocs/order_bloc.dart';
import 'package:daily_basket_sellers/views/order_details_view.dart';
import 'package:flutter/material.dart';

class OrderDashboardView extends StatefulWidget {
  @override
  _OrderDashboardViewState createState() => _OrderDashboardViewState();
}

class _OrderDashboardViewState extends State<OrderDashboardView> {
  CustomerOrderBloc _customerOrderBloc = CustomerOrderBloc();
  String _sortBy = 'created_at';
  String _sortOrder = 'asc';
  int _status = 2;

  Future<void> _refreshPendingOrdersList() async {
    await _customerOrderBloc.getAllOrdersList(_sortBy, _sortOrder, _status, 1, 13, true);
    await _customerOrderBloc.getOrderStats(true);
  }

  @override
  Widget build(BuildContext context) {
    _customerOrderBloc.getAllOrdersList(_sortBy, _sortOrder, _status, 1, 20, true);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RefreshIndicator(
        onRefresh: _refreshPendingOrdersList,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder(
                stream: _customerOrderBloc.getStats,
                builder: (context, snapshot) {
                  return Container(
                    height: 145,
                    child: ListView(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: 185,
                            padding: EdgeInsets.all(30.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Today\'s orders',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.0),
                                  ),
                                  Center(
                                      child: Text(
                                    snapshot.hasData
                                        ? '${snapshot.data['todays_orders']}'
                                        : '0',
                                    style: TextStyle(
                                      fontSize: 40.0,
                                      color: Colors.white,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: 185,
                            padding: EdgeInsets.all(30.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Pending orders',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  Center(
                                      child: Text(
                                    snapshot.hasData
                                        ? '${snapshot.data['pending_orders']}'
                                        : '0',
                                    style: TextStyle(
                                      fontSize: 40.0,
                                      color: Colors.white,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: 185,
                            padding: EdgeInsets.all(30.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Total orders',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.0),
                                  ),
                                  Center(
                                      child: Text(
                                    snapshot.hasData
                                        ? '${snapshot.data['total_orders']}'
                                        : '0',
                                    style: TextStyle(
                                      fontSize: 40.0,
                                      color: Colors.white,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'Pending Orders',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: _customerOrderBloc.ordersList,
                  builder: (context, snapshot) {
                    int itemsCount =
                        snapshot.hasData ? snapshot.data.length : 0;
                    return ListView.builder(
                        padding: EdgeInsets.only(top: 10.0),
                        itemCount: itemsCount,
                        itemBuilder: (context, index) {
                          if (itemsCount == 0) {
                            return Center(
                              child: Text('No pending orders.'),
                            );
                          }
                          var splitOrderCreatedAt =
                              snapshot.data[index]['created_at'].split('T');
                          List splitOrderCreatedAtTime =
                              splitOrderCreatedAt[1].split(':');
                          String orderCreatedAtDate = splitOrderCreatedAt[0];
                          String orderCreatedAtTime =
                              '${splitOrderCreatedAtTime[0]}:${splitOrderCreatedAtTime[1]}';
                          var orderCreatedAt =
                              '$orderCreatedAtDate $orderCreatedAtTime';
                          return Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderDetailsView(
                                          snapshot.data[index]['customer_id'],
                                          snapshot.data[index]['id'])),
                                );
                              },
                              title: Text(
                                '${snapshot.data[index]['customer']['first_name']} ${snapshot.data[index]['customer']['last_name']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Placed on $orderCreatedAt',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          );
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
