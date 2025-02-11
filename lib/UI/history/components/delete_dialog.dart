// notifikasi yang berbentuk pop up dialog
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final String documentId;
  final CollectionReference dataCollection;
  const DeleteDialog({super.key, required this.documentId, required this.dataCollection, Null Function()? onConfirm});
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog( // menggunakan scafold messanger actionnya terbatas
      title: const Text(
        "Delete Data",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18
        ),
      ),
      content: const Text(
        "Are you sure you want to delete this data?",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18
        ),
      ),
      actions: [
        TextButton(
          // untuk berkomunikasi dengan db untuk melakukan penghapusan data dari db
          onPressed: () {
            dataCollection.doc(documentId).delete();
            Navigator.pop(context);
          }, 
          child: const Text(
            "Yes, Delete this data",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              backgroundColor: Colors.lightGreen
            ),
          )
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          child: const Text(
            "No",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              backgroundColor: Colors.redAccent
            ),
          )
        )
      ],
    );
  }
}