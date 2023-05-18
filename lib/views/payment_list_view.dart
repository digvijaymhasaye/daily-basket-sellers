import 'package:daily_basket_sellers/blocs/payment_bloc.dart';
import 'package:flutter/material.dart';

import 'payment_activity_detail_view.dart';

class PaymentListView extends StatefulWidget {
  @override
  _PaymentListViewState createState() => _PaymentListViewState();
}

class _PaymentListViewState extends State<PaymentListView> {
  String _sortBy = 'created_at';
  String _sortOrder = 'desc';
  int pageNo = 0;
  int pageSize = 12;
  int totalPayments = 0;
  List paymentList = [];
  bool isLoading = false;

  PaymentBloc _paymentBloc = PaymentBloc();

  loadData() async {
    var count = await _paymentBloc.getPaymentCount(false);
    totalPayments = count;
    var _payments = await _paymentBloc.getPaymentList(
        pageNo += 1, pageSize, _sortBy, _sortOrder, null, true, false);

    setState(() {
      if (_payments.length > 0) {
        paymentList.addAll(_payments);
        totalPayments -= paymentList.length;
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payments'),
        elevation: 0.0,
        centerTitle: false,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    if (totalPayments > 0) {
                      loadData();
                      // start loading data
                      setState(() {
                        isLoading = true;
                      });
                    }
                  }
                  return null;
        },
              child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10.0),
            itemCount: paymentList.length,
            itemBuilder: (context, index) {
              var splitPaymentCreatedAt =
                  paymentList[index]['created_at'].split('T');
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
                            builder: (context) => PaymentActivityDetailView(
                                paymentList[index]['id'])),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      child: Text(
                        '${paymentList[index]['customer']['first_name'][0]}${paymentList[index]['customer']['last_name'][0]}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      '${paymentList[index]['customer']['first_name']} ${paymentList[index]['customer']['last_name']}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                    subtitle: Text(
                      '$paymentCreatedAt',
                    ),
                    trailing: Text(
                      '₹ ${paymentList[index]['amount'] / 100}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ));
            }),
      ),
    );
  }
}
