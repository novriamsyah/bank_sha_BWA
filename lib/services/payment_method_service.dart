import 'dart:convert';

import 'package:bank_sha/models/payment_method_model.dart';
import 'package:bank_sha/services/auth_service.dart';
import 'package:bank_sha/shared/shared_values.dart';
import 'package:http/http.dart' as http;

class PaymentMethodService {
  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    try {
      final token = await AuthServices().getToken();

      final res = await http.get(
        Uri.parse(
          '$baseUrl/payment_methods',
        ),
        headers: {
          'Authorization': token,
        },
      );

      // print(res);
      // print("cek");
      // print(res.body);
      // print(res.statusCode);

      if (res.statusCode == 200) {
        List<PaymentMethodModel> paymentMethods = List<PaymentMethodModel>.from(
          jsonDecode(res.body).map(
            (paymentMethod) => PaymentMethodModel.fromJson(paymentMethod),
          ),
        ).toList();

        return paymentMethods;
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
