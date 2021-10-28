import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

// ignore: must_be_immutable
class LabScreen extends StatefulWidget {
  @override
  _LabScreenState createState() => _LabScreenState();
}

class _LabScreenState extends State<LabScreen> {
  String _dropDownValue = "";
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('labTest')
          .where("address", isEqualTo: "$_dropDownValue")
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');

        if (snapshot.hasData) {
          final docs = snapshot.data!.docs;
          return Scaffold(
              appBar: myAppBar("lab Test"),
              drawer: MyDrawer(),
              body: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: DropdownButton(
                      hint: _dropDownValue == ""
                          ? Text('Please select hospital')
                          : Text(_dropDownValue),
                      isExpanded: true,
                      iconSize: 30.0,
                      items: [
                        'Bir Hospital',
                        'Teaching Hospital',
                        'Peoples Dental'
                      ].map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            _dropDownValue = val.toString();
                            print(_dropDownValue);
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (_, i) {
                        final data = docs[i].data();
                        return Container(
                          margin: EdgeInsets.all(16.0),
                          child: Card(
                            child: ListTile(
                              title: Text(data['name']),
                              subtitle: Text("Rs. " + data['price']),
                              trailing: Text(data['hospital']),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ));
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
