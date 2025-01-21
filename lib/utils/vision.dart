import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class Vision {
  /* konstruktor private Jadi, konstruktor ini tidak bisa digunakan 
  oleh kelas lain di file berbeda.(bertujuan untuk pendeteksian wajah),
  _() pada konstruktor menunjukkan bahwa konstruktor tersebut private
  */
  Vision._(); 

  static final Vision instance = Vision._();

  FaceDetector faceDetector([FaceDetectorOptions? option]) {
    return FaceDetector(options: option ?? FaceDetectorOptions());
  }
}