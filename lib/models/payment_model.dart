import 'package:daily_basket_sellers/models/customer_model.dart';

class PaymentModel {
  int id;
  int type;
  int orderId;
  int amount;
  int status;
  String paymentMethod;
  String rzpOrderId;
  String rzpPaymentId;
  String createdAt;
  CustomerModel customer;

  PaymentModel({
    this.id,
    this.type,
    this.orderId,
    this.amount,
    this.status,
    this.paymentMethod,
    this.rzpOrderId,
    this.rzpPaymentId,
    this.createdAt,
    this.customer,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> paymentJson) {
    return PaymentModel(
      id: paymentJson['id'],
      type: paymentJson['type'],
      orderId: paymentJson['order_id'],
      amount: paymentJson['amount'],
      status: paymentJson['status'],
      paymentMethod: paymentJson['rzp_payment_method'],
      rzpOrderId: paymentJson['rzp_order_id'],
      rzpPaymentId: paymentJson['rzp_payment_id'],
      createdAt: paymentJson['created_at'],
      customer: paymentJson['customer'] == null ? null : CustomerModel.fromJson(paymentJson['customer']),
    );
  }
}