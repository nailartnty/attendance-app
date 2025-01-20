import 'package:attendance/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // buat pertamakali inisialisasi firebase agar dapat menggunakan layanan yang ada di firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      // data diambil dari file google-services.json
      apiKey: 'AIzaSyDJnDFP0iy5ru5-MtW024rJvSTyjRMhwnQ', // diambil dari (current_key)
      // kode unik yg sifatnya rahasia, yang digunakan untuk mengidentifikasi aplikasi ke Firebase.

      appId: '1:477499022312:android:784737264554fa1dc6e25d', // diambil di (mobilesdk_app_id)
      // ID unik aplikasi yg dipake untuk ngenalin aplikasi ke Firebase.

      messagingSenderId: '477499022312', // diambil dari (project_number)
      // ID pengirim pesan untuk fitur Firebase Cloud Messaging (FCM). Ini yang dipakai kalau kamu mau kirim notifikasi push.

      projectId: 'attendance-app-a8769' // diambil dari (project_id)
      // identitas project firebase
    )
  ); // yang sering dipake itu App() sama initializeApp()
  runApp(const AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      theme: ThemeData(
        cardTheme: CardTheme(surfaceTintColor: Colors.white),
        dialogTheme: DialogTheme(surfaceTintColor: Colors.white, backgroundColor: Colors.white),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true
      ),
      home: const HomeScreen(),
    );
  }
}