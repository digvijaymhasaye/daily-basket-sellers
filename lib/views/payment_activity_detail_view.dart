import 'package:daily_basket_sellers/blocs/payment_bloc.dart';
import 'package:flutter/material.dart';

class PaymentActivityDetailView extends StatefulWidget {
  int paymentId;

  PaymentActivityDetailView(this.paymentId);
  @override
  _PaymentActivityDetailViewState createState() =>
      _PaymentActivityDetailViewState(this.paymentId);
}

class _PaymentActivityDetailViewState extends State<PaymentActivityDetailView> {
  int _paymentId;
  PaymentBloc _paymentBloc = PaymentBloc();
  _PaymentActivityDetailViewState(this._paymentId);

  @override
  void initState() {
    _paymentBloc.getPaymentDetails(_paymentId, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: StreamBuilder(
          stream: _paymentBloc.getPayment,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var splitPaymentCreatedAt = snapshot.data.createdAt.split('T');
              List splitPaymentCreatedAtTime =
                  splitPaymentCreatedAt[1].split(':');
              String paymentCreatedAtDate = splitPaymentCreatedAt[0];
              String paymentCreatedAtTime =
                  '${splitPaymentCreatedAtTime[0]}:${splitPaymentCreatedAtTime[1]}';
              var paymentCreatedAt =
                  '$paymentCreatedAtDate $paymentCreatedAtTime';
              return ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                radius: 40.0,
                                child: Text(
                                  '${snapshot.data.customer.firstName[0]}${snapshot.data.customer.lastName[0]}',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                snapshot.data.amount > 100
                                    ? '₹ ${snapshot.data.amount / 100}'
                                    : 0,
                                style: TextStyle(fontSize: 26.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text('Received from'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(snapshot.data.customer == null
                                  ? ''
                                  : '${snapshot.data.customer.firstName} ${snapshot.data.customer.lastName}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15
                                  ),),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Card(
                    elevation: 1.5,
                    margin: EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Icon(
                                        Icons.done,
                                        size: 23.0,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Received ₹ ${snapshot.data.amount/100}'),
                                  Text(
                                    paymentCreatedAt,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 10.0,
                          thickness: 0.5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Trasaction ID',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text('${snapshot.data.id}'),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Order ID',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text('${snapshot.data.orderId}'),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'RazorPay payment ID',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text('${snapshot.data.rzpPaymentId}'),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'RazorPay order ID',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text('${snapshot.data.rzpOrderId}'),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'From: ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  Text(snapshot.data.customer == null
                                      ? ''
                                      : '${snapshot.data.customer.firstName} ${snapshot.data.customer.lastName}'),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
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
                                  Text('${snapshot.data.paymentMethod}'),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }
            return Center(
              child: Text('Payment not found'),
            );
          }),
    );
  }
}
