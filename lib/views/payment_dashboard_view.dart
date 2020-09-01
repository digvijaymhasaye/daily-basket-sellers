import 'package:daily_basket_sellers/blocs/payment_bloc.dart';
import 'package:daily_basket_sellers/views/payment_activity_detail_view.dart';
import 'package:daily_basket_sellers/views/payment_list_view.dart';
import 'package:flutter/material.dart';

class PaymentDashboardView extends StatefulWidget {
  @override
  _PaymentDashboardViewState createState() => _PaymentDashboardViewState();
}

class _PaymentDashboardViewState extends State<PaymentDashboardView> {
  String _sortBy = 'created_at';
  String _sortOrder = 'desc';
  // int _status = 2;
  int pageNo = 1;
  int pageSize = 10;

  PaymentBloc _paymentBloc = PaymentBloc();

  Future<void> _refreshPendingTransactionsList() async {
    // await _paymentBloc.getPaymentList(
    //     pageNo, pageSize, _sortBy, _sortOrder, null, true);
    await _paymentBloc.getPaymentStats(true);
  }

  @override
  void initState() {
    _paymentBloc.getPaymentStats(true);
    _paymentBloc.getPaymentList(
        pageNo, pageSize, _sortBy, _sortOrder, null, true, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          StreamBuilder(
              stream: _paymentBloc.getPaymentStatsCount,
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
                          // height: 200,
                          padding: EdgeInsets.all(18.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Today\'s payments',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14.0),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                      child: Text(
                                    snapshot.hasData
                                        ? snapshot.data['daily_payment'] > 100
                                            ? '₹ ${snapshot.data['daily_payment'] / 100}'
                                            : '₹ 0'
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: 185,
                          padding: EdgeInsets.all(18.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Weekly payments',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Text(
                                  '(last 7 days)',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                    child: Text(
                                  snapshot.hasData
                                      ? snapshot.data['weekly_payment'] > 100
                                          ? '₹ ${snapshot.data['weekly_payment'] / 100}'
                                          : '₹ 0'
                                      : '0',
                                  style: TextStyle(
                                    fontSize: 37.0,
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
                          padding: EdgeInsets.all(18.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Total payments',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.0),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                      child: Text(
                                    snapshot.hasData
                                        ? snapshot.data['total_payment'] > 100
                                            ? '₹ ${snapshot.data['total_payment'] / 100}'
                                            : '₹ 0'
                                        : '0',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Recent Payments',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentListView()),
                  );
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
                stream: _paymentBloc.getPaymentsList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10.0),
                        itemCount: snapshot.data.length > 10
                            ? 10
                            : snapshot.data.length,
                        itemBuilder: (context, index) {
                          var splitPaymentCreatedAt =
                              snapshot.data[index]['created_at'].split('T');
                          List splitPaymentCreatedAtTime =
                              splitPaymentCreatedAt[1].split(':');
                          String paymentCreatedAtDate = splitPaymentCreatedAt[0];
                          String paymentCreatedAtTime =
                              '${splitPaymentCreatedAtTime[0]}:${splitPaymentCreatedAtTime[1]}';
                          var paymentCreatedAt =
                              '$paymentCreatedAtDate $paymentCreatedAtTime';
                          return Card(
                              margin: EdgeInsets.all(5.0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PaymentActivityDetailView(snapshot.data[index]['id'])),
                                  );
                                },
                                leading: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).accentColor,
                                  child: Text(
                                    '${snapshot.data[index]['customer']['first_name'][0]}${snapshot.data[index]['customer']['last_name'][0]}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                title: Text(
                                  '${snapshot.data[index]['customer']['first_name']} ${snapshot.data[index]['customer']['last_name']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                subtitle: Text(
                                  '$paymentCreatedAt',
                                ),
                                trailing: Text(
                                  '₹ ${snapshot.data[index]['amount'] / 100}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ));
                        });
                  }
                  return Center(child: Text('No payments'));
                }),
          ),
        ],
      ),
    );
  }
}
