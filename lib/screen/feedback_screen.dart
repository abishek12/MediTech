import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';

// ignore: must_be_immutable
class FeedBackScreen extends StatelessWidget {
  String docID;
  var docRating;

  FeedBackScreen({required this.docID, required this.docRating});

  @override
  Widget build(BuildContext context) {
    postFeedback(double rating) {
      DocumentReference<Map<String, dynamic>> user =
          FirebaseFirestore.instance.collection("user").doc(docID);
      user
          .update({
            'rating': docRating + rating,
          })
          .then((value) => AlertDialog(
                title: Text("Successful"),
                content: Text("Task Completed"),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Close"),
                  ),
                ],
              ))
          .catchError((error) => AlertDialog(
                title: Text("Error"),
                content: Text("Something went wrong"),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Close"),
                  ),
                ],
              ));
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
        ],
      ),
    );
  }
}
