import 'package:daily_basket_sellers/blocs/order_bloc.dart';
import 'package:daily_basket_sellers/views/payment_activity_detail_view.dart';
import 'package:flutter/material.dart';

class OrderDetailsView extends StatefulWidget {
  int customerId;
  int orderId;
  OrderDetailsView(this.customerId, this.orderId);

  @override
  _OrderDetailsViewState createState() =>
      _OrderDetailsViewState(this.customerId, this.orderId);
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  int _customerId;
  int _paymentId = 0;
  int _orderId;
  CustomerOrderBloc _customerOrderBloc = CustomerOrderBloc();

  _OrderDetailsViewState(this._customerId, this._orderId);
  static List status = [
    'Initiated',
    'Placed',
    'Received',
    'Out for delivery',
    'Delivered',
    'Cancelled',
    'Failed'
  ];

  var dropdownValue = 'Received';
  final List<DropdownMenuItem> orderStauses =
      status.map<DropdownMenuItem<String>>((value) {
    return DropdownMenuItem(
      value: value,
      child: Text(value),
    );
  }).toList();

  String getStatus(status) {
    return 'Initiated';
  }

  @override
  Widget build(BuildContext context) {
    _customerOrderBloc.getCustomerOrder(_customerId, _orderId, true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (result) {
              // (result);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PaymentActivityDetailView(_paymentId)),
              );
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'payment_details',
                  child: Text('Check payment details'),
                ),
              ];
            },
          ),
        ],
      ),
      body: StreamBuilder(
          stream: _customerOrderBloc.order,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var splitOrderCreatedAt = snapshot.data.createdAt.split('T');
              List splitOrderCreatedAtTime = splitOrderCreatedAt[1].split(':');
              String orderCreatedAtDate = splitOrderCreatedAt[0];
              String orderCreatedAtTime =
                  '${splitOrderCreatedAtTime[0]}:${splitOrderCreatedAtTime[1]}';
              var orderCreatedAt = '$orderCreatedAtDate $orderCreatedAtTime';
              dropdownValue = status[snapshot.data.status];
              return Container(
                child: ListView(
                  children: <Widget>[
                    Card(
                        margin: EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 40.0, horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Order No.: ${snapshot.data.id}',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0),
                                child: Text(
                                  '${snapshot.data.customer.firstName} ${snapshot.data.customer.lastName}',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0),
                                child: Text(
                                  '${snapshot.data.address.addressLine1}, ${snapshot.data.address.addressLine2}, ${snapshot.data.address.postalCode}',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        )
                        // ListTile(
                        //   contentPadding: EdgeInsets.all(20.0),
                        //   isThreeLine: true,
                        //   title: Text(
                        //     '${snapshot.data.customer.firstName} ${snapshot.data.customer.lastName}',
                        //     style: TextStyle(fontWeight: FontWeight.w600),
                        //   ),
                        //   subtitle: Padding(
                        //     padding: const EdgeInsets.symmetric(vertical: 8.0),
                        //     child: Text(
                        //         '${snapshot.data.address.addressLine1}, ${snapshot.data.address.addressLine2}, ${snapshot.data.address.postalCode}'),
                        //   ),
                        // ),
                        ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Total items',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${snapshot.data.itemsCount}',
                                        style: TextStyle(
                                          fontSize: 22.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  thickness: 1.0,
                                  width: 10,
                                  color: Colors.black,
                                ),
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Total Amount',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '₹ ${snapshot.data.totalPrice / 100}',
                                        style: TextStyle(
                                          fontSize: 22.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Divider(
                              height: 20.0,
                              thickness: 0.8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Order placed on',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Text('$orderCreatedAt'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Order status: ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: DropdownButton(
                                          value: dropdownValue,
                                          items: [
                                            'Received',
                                            'Out for delivery',
                                            'Delivered',
                                            'Cancelled'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (abc) async {
                                            var i = status.indexOf(abc);
                                            await _customerOrderBloc
                                                .updateCustomerOrderStatus(
                                                    _customerId,
                                                    _orderId,
                                                    i,
                                                    false);
                                            _customerOrderBloc.getAllOrdersList(
                                                'created_at', 'asc', 2, 1, 10, true);
                                            _customerOrderBloc.getOrderStats(true);
                                            setState(() {
                                              dropdownValue = abc;
                                            });
                                          })),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Payment method: ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(snapshot.hasData
                                        ? (snapshot.data.paymentType == 1
                                            ? 'Credit/Debit/IB/UPI'
                                            : 'Cash on delivery')
                                        : '-'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Payment status: ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(snapshot.hasData
                                        ? (snapshot.data.paymentType == 1
                                            ? getStatus(
                                                snapshot.data.payment.status)
                                            : '-')
                                        : '-'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 8.0, right: 8.0),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10.0),
                              child: Text(
                                'Ordered Products',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data.orderItems.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    margin: EdgeInsets.all(5.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(10.0),
                                      leading: Image.network(
                                        '${snapshot.data.orderItems[index]['product']['image']['url']}',
                                        fit: BoxFit.fill,
                                      ),
                                      title: Text(
                                        '${snapshot.data.orderItems[index]['product']['name']}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0,
                                          letterSpacing: 0.4,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${snapshot.data.orderItems[index]['quantity']} x ₹ ${snapshot.data.orderItems[index]['price']}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.4,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
