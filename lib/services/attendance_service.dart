import 'package:attendance/UI/home_screen.dart';
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
      Navigator.of(context).pop();
      try { // kalau dia udah berhasil ke submit
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle_outline,
                color: Colors.white,
              ),
              SizedBox(width: 10,),
              Text(
                'Attendance Report submitted successfully',
                style: TextStyle(color: Colors.white),
              )
            ]
          ),
          backgroundColor: Colors.orangeAccent,
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
        ));
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const HomeScreen())
        );
      } catch (e) { // kalau dia gagal submit
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.info_outline, 
                color: Colors.white
              ), 
              const SizedBox(width: 10),
              Expanded(child: Text(
                "Ups! $e",
                style: const TextStyle(color: Colors.white),
              ))
            ],
          ),
          backgroundColor: Colors.blueAccent,
          shape: const StadiumBorder(),
          behavior: SnackBarBehavior.floating,
        ));
      }
    }
    // untuk menampilkan error yang 
  ).catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Ups! $error",
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      backgroundColor: Colors.blueAccent,
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
    ));
    Navigator.of(context).pop();
  });
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