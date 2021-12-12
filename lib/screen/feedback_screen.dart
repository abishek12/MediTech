import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';

// ignore: must_be_immutable
class FeedBackScreen extends StatelessWidget {
  String docID;
  FeedBackScreen({required this.docID});

  @override
  Widget build(BuildContext context) {
    postFeedback(double rating) {
      FirebaseFirestore.instance.collection("users")
          .doc('$docID')
          .update({'rating': '$rating'})
          .then((value) => print("User rating Updated"))
          .catchError((error) => print("Failed to update user: $error"));
    }

    _checkNotification(){
    }

    return Scaffold(
      appBar: myAppBar("Feedback"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Text(
              "Rating",
              style: MyStyles.paragraph,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.blue,
              ),
              onRatingUpdate: (rating) {
                postFeedback(rating);
              },
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: (){
                _checkNotification();
              },
              child: Text("Check Notification"),
            ),
          )
        ],
      ),
    );
  }
}
