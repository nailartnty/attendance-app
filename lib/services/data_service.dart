import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance');

  Future<QuerySnapshot> getData() { // QuerySnapshot itu kayak kotak berisi daftar kertas (dokumen) yang kita ambil dari sebuah rak (koleksi) di perpustakaan (Firestore).
    return dataCollection.get(); // buat dapetin datanya
  }

  // methode untuk mendelete
  Future<void> deleteData(String docId) { // docId itu id dokumen yang mau dihapus
    return dataCollection.doc(docId).delete();  // Ambil Dokumen Tertentu
  }
}