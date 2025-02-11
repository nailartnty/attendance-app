import 'dart:math';
import 'package:attendance/UI/history/components/delete_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onDelete; // handler untuk delete activity 
  const HistoryCard({super.key, required this.data, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DeleteDialog(
          documentId: data["id"], 
          dataCollection: FirebaseFirestore.instance.collection('attendance'),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          
        ),
        elevation: 5,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)], // perhitungan matematika untuk menghasilkan warna yang random
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Center(
                  child: Text(
                    // ['name'][0] menampilkan nama dari index yg pertama
                    data['name'][0].toUpperCase(), 
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          flex: 4,
                          child: Text(
                            "Name",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            data['name'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14
                            ),
                          ),
                        )
                      ]
                    ),
                    Row(
                      children: [
                        const Text(
                          "Attendance Status",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14
                          ),
                        ),
                        Text(
                          data['description'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14
                          ),
                        )
                      ]
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}