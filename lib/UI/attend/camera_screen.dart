import 'package:attendance/UI/attend/camera-components/camera_controller.dart';
import 'package:attendance/UI/attend/camera-components/face_detector.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with TickerProviderStateMixin { // with TickerProviderStateMixin adlh untuk membuat animasi controller
  late CameraControllerComponent cameraControllerComponent; // late untuk menghindari error karena belum diinisiasi
  late FaceDetectorComponent faceDetectorComponent;

  @override
  void initState() {
    super.initState();
    cameraControllerComponent = CameraControllerComponent();
    faceDetectorComponent = FaceDetectorComponent();
    cameraControllerComponent.loadCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cameraControllerComponent.builCameraPreview(),
    );
  }
}