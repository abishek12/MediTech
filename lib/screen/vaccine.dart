import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

class VaccineScreen extends StatefulWidget {
  const VaccineScreen({Key? key}) : super(key: key);

  @override
  _VaccineScreenState createState() => _VaccineScreenState();
}

class _VaccineScreenState extends State<VaccineScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> _locations = [
      'Kathmandu',
      'Bhaktapur',
      'Lalitpur',
      'Chitwan',
      'Pokhara'
    ];
    String _selectedLocation = "";
    return Scaffold(
      appBar: myAppBar("Vaccine"),
      drawer: MyDrawer(),
      body: Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Location: ",
                    style: MyStyles.headingFour,
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  DropdownButton<String>(
                    hint: _selectedLocation == ""
                        ? Text("Please select a location")
                        : Text(_selectedLocation),
                    items: _locations.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedLocation = value.toString();
                        print(_selectedLocation);
                      });
                    },
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, value) {
                    return ListTile(
                      leading: Icon(CupertinoIcons.house_alt),
                      title: Text("Bagmati Hospital"),
                      subtitle: Text("Banasthali, Kathmandu"),
                      trailing: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          "Visit",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          )),
    );
  }
}
