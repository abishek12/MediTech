import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

// ignore: must_be_immutable
class HospitalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _hospitalStream =
        FirebaseFirestore.instance.collection('hospital').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _hospitalStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return AlertDialog(
            content: Text('Something went wrong'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Go Back"),
              )
            ],
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return AlertDialog(
            content: Text('There is no data'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Go Back"),
              )
            ],
          );
        }

        return Scaffold(
          appBar: myAppBar("Hospital"),
          drawer: MyDrawer(),
          body: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['full_name']),
                subtitle: Text(data['company']),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
