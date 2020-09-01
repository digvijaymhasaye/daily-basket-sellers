import 'package:daily_basket_sellers/blocs/customer_bloc.dart';
import 'package:daily_basket_sellers/blocs/order_bloc.dart';
import 'package:flutter/material.dart';

class CustomerDetailsView extends StatefulWidget {
  final int id;
  CustomerDetailsView(this.id);
  @override
  _CustomerDetailsViewState createState() => _CustomerDetailsViewState(this.id);
}

class _CustomerDetailsViewState extends State<CustomerDetailsView> {
  CustomerBloc _customerBloc = CustomerBloc();
  CustomerOrderBloc _customerOrderBloc = CustomerOrderBloc();
  int _id;

  _CustomerDetailsViewState(this._id);

  @override
  Widget build(BuildContext context) {
    _customerBloc.getCustomer(_id);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
            stream: _customerBloc.getCustomerDetailsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    Card(
                      elevation: 1.0,
                      child: StreamBuilder(
                          stream: _customerBloc.getCustomerDetailsStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              _customerOrderBloc.getCustomerOrderItems(
                                  _id, true);
                              return Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 30,
                                          child: Text(
                                            '${snapshot.data.firstName[0]}${snapshot.data.lastName[0]}',
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${snapshot.data.firstName}${snapshot.data.lastName}',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.4),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 3.0),
                                              child: Text(
                                                  'Mobile No.: ${snapshot.data.mobileNo}'),
                                            ),
                                            Text(
                                                'Registered on ${snapshot.data.createdAt.split('T')[0]}'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }
                            return Center(child: CircularProgressIndicator());
                          }),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Card(
                        margin: EdgeInsets.all(5.0),
                        elevation: 1.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Orders',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Expanded(
                                child: StreamBuilder(
                                    stream: _customerOrderBloc.getOrderItems,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return ListView.builder(
                                          itemCount: snapshot.hasData
                                              ? (snapshot.data.length > 6
                                                  ? 6
                                                  : snapshot.data.length)
                                              : 0,
                                          itemBuilder: (context, index) {
                                            return Card(
                                                child: ListTile(
                                              leading: Image.network(snapshot
                                                      .data[index]['product']
                                                  ['images'][0]['url']),
                                              title: Text(
                                                snapshot.hasData
                                                    ? '${snapshot.data[index]['product']['name']} x ${snapshot.data[index]['quantity']}'
                                                    : '',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              subtitle: Text(
                                                  'Ordered on ${snapshot.data[index]['created_at'].split('T')[0]}'),
                                            ));
                                          },
                                        );
                                      }
                                      return Center(child: Text('No orders'));
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
