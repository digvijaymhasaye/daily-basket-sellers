import 'dart:async';

import 'package:daily_basket_sellers/repositories/payment_repository.dart';

class PaymentBloc {
  static final _paymentListStreamController = StreamController.broadcast();
  static final _paymentStatsStreamController = StreamController.broadcast();
  static final _paymentDetailsStreamController = StreamController.broadcast();
  static final _paymentCountStreamController = StreamController.broadcast();

  PaymentRepository _paymentRepository = PaymentRepository();

  Stream get getPaymentsList => _paymentListStreamController.stream;
  Stream get getPaymentStatsCount => _paymentStatsStreamController.stream;
  Stream get getPaymentsCount => _paymentStatsStreamController.stream;
  Stream get getPayment => _paymentDetailsStreamController.stream;

  getPaymentList(int pageNo, int pageSize, String sortBy, String sortOrder, int status, bool includeCustomerDetails, bool returnAsStream) async {
    var payments = await _paymentRepository.getPaymentList(pageNo, pageSize, sortBy, sortOrder, status, includeCustomerDetails);
    if (returnAsStream) {
      _paymentListStreamController.sink.add(payments);
    } else {
      return payments;
    }
  }

  getPaymentStats(bool returnAsStream) async {
    var stats = await _paymentRepository.getPaymentStats();
    if (returnAsStream) {
      _paymentStatsStreamController.sink.add(stats);
    } else {
      return stats;
    }
  }

  getPaymentCount(bool returnAsStream) async {
    var count = await _paymentRepository.getPaymentCount();
    if (returnAsStream) {
      _paymentCountStreamController.sink.add(count);
    } else {
      return count;
    }
  }

  getPaymentDetails(int paymentId, bool returnAsStream) async {
    var payment = await _paymentRepository.getPayment(paymentId);
    if (returnAsStream) {
      _paymentDetailsStreamController.sink.add(payment);
    } else {
      return payment;
    }
  }

  void dispose() {
    _paymentListStreamController.close();
    _paymentStatsStreamController.close();
    _paymentDetailsStreamController.close();
    _paymentCountStreamController.close();
  }
}