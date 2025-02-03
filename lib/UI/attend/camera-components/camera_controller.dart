import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraControllerComponent {
  List<CameraDescription>? cameras;
  CameraController? controller;
  bool isBusy = false;

  Future<void> loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null && cameras!.isNotEmpty) { // kamera bekerja
      controller = CameraController(cameras![0], ResolutionPreset.high); // untk mengatur maching datanya biar gerak dikir kga blur asoyy
      await controller!.initialize(); // harus ada isinya biar dia bisa diinisialisasi
    }
  }
  
  Widget buildCameraPreview() {
    if (controller == null || !controller!.value.isInitialized) {
      // aksi apabila kondisi bernilai negatif
      return const Center(child: CircularProgressIndicator());
    }
    // aksi apabila kondisi bernilai positif
    return CameraPreview(controller!);
  }
}

// NOTE's
// cameras → Merujuk ke daftar kamera yang tersedia di perangkat (misalnya kamera depan & belakang).
// ! → Operator null assertion, digunakan untuk memastikan bahwa cameras tidak null.
// [0] → Mengakses elemen pertama dalam daftar kamera (biasanya kamera belakang).
// ! dibelakang = nullsafty/ada isi, ! didepan method = not/negasi