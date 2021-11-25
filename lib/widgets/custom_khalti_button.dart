import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class CustomKhaltiPay extends StatelessWidget {
  const CustomKhaltiPay({
    Key? key,
    required this.config,
    required this.onSuccess,
    required this.onFailure,
    required this.onCancel,
  }) : super(key: key);

  final PaymentConfig config;
  final ValueChanged<PaymentSuccessModel> onSuccess;
  final ValueChanged<PaymentFailureModel> onFailure;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.payment,
        color: Colors.lightGreen,
      ),
      onPressed: () {
        // Navigator.pushNamed(context, "/labPayment");
        KhaltiScope.of(context).pay(
          config: config,
          preferences: [
            PaymentPreference.khalti,
          ],
          onSuccess: onSuccess,
          onFailure: onFailure,
          onCancel: onCancel,
        );
      },
    );
  }
}
