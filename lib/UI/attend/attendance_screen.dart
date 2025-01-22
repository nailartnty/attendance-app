import 'dart:io';

import 'package:attendance/UI/attend/camera_screen.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  final XFile? image;

  const AttendanceScreen({super.key, required this.image});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState(this.image);
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  _AttendanceScreenState(this.image);

  // DEFAULT VALUE yg kita buat
  XFile? image;
  String address = "", date = "", time = "", dateTime = "", status = "Attend"; // time-stand 
  bool isLoading = false;
  double lat = 0.0, long = 0.0; // untuk posisi titik koordinat kita atau untuk menangani lokasi geografis perangkat
  int dateHours = 0, minute = 0;
  final controller = TextEditingController(); // untuk masukin nama pengguna
  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance'); // untuk colecting data

  @override
  void initState() {
    super.initState();
    handleLocationPermission();
    setDataTime();
    setAttendStatus();
    
    if (image != null) {
      isLoading = true;
      getGeoLocationPosition();
    }
  }

  @override // -> annotation
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // mempresantasikan ukuran layar

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        leading: IconButton( 
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Attendance Report",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(10, 20, 5, 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                  ),
                  color: Colors.blueAccent
                ),
                child: const Row(
                  children: <Widget> [
                    SizedBox(width: 12),
                    Icon(Icons.face_retouching_natural_outlined),
                    SizedBox(width: 12),
                    Text(
                      "Please scan your Face!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
                child: Text(
                  "Capture Image",
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const CameraScreen())
                  );
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  width: size.width,
                  height: 150,
                  child: DottedBorder(
                    radius: const Radius.circular(10),
                    borderType: BorderType.RRect,
                    strokeWidth: 1,
                    dashPattern: const [5, 5],
                    child: SizedBox.expand( // kayak expanded tapi dia bawaan sizebox
                      child: FittedBox(
                        child: image != null ?
                        Image.file(File(image!.path), fit: BoxFit.cover)
                        : const Icon(Icons.camera_enhance_outlined)
                      ),
                    )
                  ),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}