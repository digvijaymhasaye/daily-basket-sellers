import 'package:daily_basket_sellers/api-providers/payment_api_provider.dart';

class PaymentRepository {
  PaymentApiProvider _paymentApiProvider = PaymentApiProvider();

  getPaymentList(int pageNo, int pageSize, String sortBy, String sortOrder,
          int status, bool includeCustomerDetails) async =>
      await _paymentApiProvider.getPaymentsList(
          pageNo, pageSize, sortBy, sortOrder, status, includeCustomerDetails);

  getPaymentStats() async => await _paymentApiProvider.getPaymentStats();

  getPaymentCount() async => await _paymentApiProvider.getPaymentCount();

  getPayment(int paymentId) async => await _paymentApiProvider.getPaymentById(paymentId);
}
