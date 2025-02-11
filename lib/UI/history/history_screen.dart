import 'package:attendance/UI/history/components/delete_dialog.dart';
import 'package:attendance/UI/history/components/history_card.dart';
import 'package:attendance/services/data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttandanceHistoryScreen extends StatefulWidget {
  const AttandanceHistoryScreen({super.key});

  @override
  State<AttandanceHistoryScreen> createState() => _AttandanceHistoryScreenState();
}

class _AttandanceHistoryScreenState extends State<AttandanceHistoryScreen> {
  final DataService dataService = DataService(); // nurunin sifat2 dataService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance History"),
      ),
      body: StreamBuilder( // untuk membungkus semua widget menjadi kesatuan, membuat ui kita menjadi termenage dngn baik
        stream: dataService.dataCollection.snapshots(), // snapshots() untuk menghandle data yang kita ambil, kasih tau ke ui bahwa data kita udah siap dikonsum si ui
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) { // kalau gak punya data
            return const Center(child: Text("There's no data"));
          }

          // docs representasi semua data yang ad di firebase
          final data = snapshot.data!.docs;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return HistoryCard(
                // fungsiya untuk mendefinisikan data yang akan muncul di ui berdasarkan index/posisi yang ada di db
                data: data[index].data() as Map<String, dynamic>, 
                onDelete: () {
                  showDialog(
                    context: context, 
                    builder: (context) => DeleteDialog(
                      // untuk menjadikan index sebagai id dari data yang ada di db
                      documentId: data[index].id, 
                      dataCollection: dataService.dataCollection, 
                      // digunakan untuk memperbarui state stelah terjadi penghapusan dari db
                      onConfirm: () { 
                        setState(() {
                          dataService.deleteData(data[index].id);
                          Navigator.pop(context);
                        });
                       },
                    )
                  );
                }
              );
            }
          );
        }
      ),
    );
  }
}