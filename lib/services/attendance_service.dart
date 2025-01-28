import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// entry point for submitting the attenddace report
final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance');

Future<void> submitAttendaceReport(BuildContext context,
  String address, 
  String name, 
  String attendaceStatus, 
  String timeStamp) async {
    showLoaderDialog(context);
    dataCollection.add(
      {
        'address': address,
        'name' : name,
        'description': attendaceStatus,
        'time': timeStamp
      }
    ).then((result) {
      
    }
  );
}

void showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator( // Loading Indikator
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: const Text(
            "Checking the Data..."
          ),
        )
      ]
    )
  );

  // nampilin pop up dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    }
  );
}