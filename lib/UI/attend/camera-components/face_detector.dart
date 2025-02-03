import 'package:attendance/utils/google_ml_kit.dart';
import 'package:camera/camera.dart';
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
    // TODO: implement face detection awokawok
  }
}