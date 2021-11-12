import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

// ignore: must_be_immutable
const String testPublicKey = 'test_public_key_dc74e0fd57cb46cd93832aee0a507256';

class LabScreen extends StatelessWidget {
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
                return Container(
                  margin: EdgeInsets.all(16.0),
                  child: Card(
                    child: ListTile(
                      leading: Image.asset("assets/icons/hospital.png"),
                      title: Text(data['name']),
                      subtitle: Text(
                        data['price'],
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.payment,
                          color: Colors.lightGreen,
                        ),
                        onPressed: () {

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
