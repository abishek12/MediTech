import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';
import 'package:medicalapp/widgets/custom_khalti_button.dart';

// ignore: must_be_immutable
class LabScreen extends StatefulWidget {
  @override
  State<LabScreen> createState() => _LabScreenState();
}

class _LabScreenState extends State<LabScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('labTest').snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');

        if (snapshot.hasData) {
          final docs = snapshot.data!.docs;
          return Scaffold(
            appBar: myAppBar("Lab Test"),
            drawer: MyDrawer(),
            body: ListView.builder(
              itemCount: docs.length,
              itemBuilder: (_, i) {
                final data = docs[i].data();
                final config = PaymentConfig(
                  amount: int.parse(data['price']) *
                      100, // Amount should be in paisa
                  productIdentity:
                      i.toString(), // here pass data['id'] if there is so
                  productName: data['name'],
                  // productUrl: 'https://www.khalti.com/#/bazaar',
                  additionalData: {
                    // Not mandatory; can be used for reporting purpose
                    'vendor': 'Khalti Bazaar',
                  },
                );
                return Container(
                  margin: EdgeInsets.all(16.0),
                  child: Card(
                    child: ListTile(
                      leading: Image.asset("assets/icons/hospital.png"),
                      title: Text(data['name']),
                      subtitle: Text(
                        data['price'],
                      ),
                      trailing: CustomKhaltiPay(
                        config: config,
                        onSuccess: (PaymentSuccessModel success) {
                          print(success.toString());
                        },
                        onFailure: (PaymentFailureModel failure) {
                          print(failure.toString());
                        },
                        onCancel: () {
                          print("Cancelled By User");
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
