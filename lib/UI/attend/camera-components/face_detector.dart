import 'dart:math';
import 'package:attendance/utils/google_ml_kit.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectorComponent {
  final FaceDetector faceDetector = GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
    enableContours: true,
    enableLandmarks: true,
    enableClassification: true,
    enableTracking: true,
  ));

  Future<void> detectFaces(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path); // generate dari gambar ke path
    final faces = await faceDetector.processImage(inputImage); // yang proses semuanya

    for (Face face in faces) { // kalau facenya udah terdeteksi
      final Rect boundingBox = face.boundingBox;

      // buat ngehandle posisi wajah secara vertikal & horizontal
      final double? verticalPosition = face.headEulerAngleY;
      final double? horizontalPosition = face.headEulerAngleZ;

      // perkondisian apabila face landmark sudah aktif, ditandai oleh (mulut, mata, pipi, hidung, dan telinga)
      final FaceLandmark? leftEar = face.landmarks[FaceLandmarkType.leftEar];
      if(leftEar != null) {
        final Point<int> leftEarPosition = leftEar.position; // kalau telinganya terdeteksi akan mengembalikan posisi telinga tersebut
        print("Left Ear Position: $leftEarPosition"); 
      }

      // perkondisian apabila klasifikasi wajahnya terdeteksi (ditandai dengan bibir senyum)
      if (face.smilingProbability != null) {
        final double? smileProbability = face.smilingProbability;
        print("Smile Probability: $smileProbability");
      }

      // perkodisian apabila fitur tracking wajah sudah aktif
      if (face.trackingId != null) {
        final int? trackingId = face.trackingId;
        print("Tracking ID: $trackingId");
      }
    }
  }
}

// kalau kita manggil sebuah face itu pake titik 
// bounding box itu dipake untuk memberi kotak pembatas (bounding box) dari setiap wajah
// Rect agar proses absensi kita gak ditipu
// nullable ? karena mungkin tidak selalu ada di setiap deteksi wajah