import 'package:daily_basket_sellers/blocs/customer_bloc.dart';
import 'package:daily_basket_sellers/views/customer_details_view.dart';
import 'package:flutter/material.dart';

class CustomerDashboardView extends StatefulWidget {
  @override
  _CustomerDashboardViewState createState() => _CustomerDashboardViewState();
}

class _CustomerDashboardViewState extends State<CustomerDashboardView> {
  CustomerBloc _customerBloc = CustomerBloc();
  @override
  Widget build(BuildContext context) {
    _customerBloc.getCustomerList(null, null, 100);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 150,
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 27.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'New customers',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          '(last 7 days)',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Center(
                            child: Text(
                          '10',
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
                  height: 150,
                  padding: EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Total customers',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        Center(
                            child: Text(
                          '10',
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white,
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Recent Customers',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => PaymentListView()),
                  // );
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder(
                stream: _customerBloc.getCustomerListStream,
                builder: (context, snapshot) {
                  return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10.0),
                      itemCount: snapshot.hasData ? snapshot.data.length : 0,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CustomerDetailsView(
                                          snapshot.data[index]['id'])));
                            },
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).accentColor,
                              child: Text(
                                '${snapshot.data[index]['first_name'][0].toUpperCase()}${snapshot.data[index]['last_name'][0].toUpperCase()}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(snapshot.hasData
                                ? '${snapshot.data[index]['first_name']} ${snapshot.data[index]['last_name']}'
                                : ''),
                            subtitle: Text(
                                'Registered on ${snapshot.data[index]['created_at'].split('T')[0]}'),
                          ),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}
