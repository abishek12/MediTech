// import 'package:esewa_pnp/esewa.dart';
// import 'package:flutter/material.dart';
//
// import 'package:esewa_pnp/esewa_pnp.dart';
//
// class LabPaymentScreen extends StatefulWidget {
//   @override
//   _LabPaymentScreenState createState() => _LabPaymentScreenState();
// }
//
// class _LabPaymentScreenState extends State<LabPaymentScreen> {
//   late ESewaPnp _esewaPnp;
//   late ESewaConfiguration _configuration;
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//   @override
//   void initState() {
//     super.initState();
//
//     _configuration = ESewaConfiguration(
//       clientID: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
//       secretKey: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
//       environment: ESewaConfiguration.ENVIRONMENT_TEST,
//     );
//     _esewaPnp = ESewaPnp(configuration: _configuration);
//   }
//
//   double _amount = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primaryColor: Color.fromRGBO(65, 161, 36, 1),
//       ),
//       home: Scaffold(
//         key: _scaffoldKey,
//         appBar: AppBar(
//           title: Text("ESewa PNP"),
//           elevation: 0,
//         ),
//         body: Container(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               TextField(
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   setState(() {
//                     _amount = double.parse(value);
//                   });
//                 },
//                 decoration: InputDecoration(
//                   labelText: "Enter amount",
//                 ),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               ESewaPaymentButton(
//                 this._esewaPnp,
//                 amount: _amount,
//                 callBackURL: "https://example.com",
//                 productId: "abc123",
//                 productName: "Flutter SDK Example",
//                 onSuccess: (result) {
//                  print(result.message.toString());
//                 },
//                 onFailure: (e) {
//                   print(e.message.toString());
//                 },
//               ),
//               SizedBox(
//                 height: 84,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//  
// }

import 'package:flutter/material.dart';
class LabPaymentScreen extends StatelessWidget {
  const LabPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

