import 'package:attendance/UI/permission/components/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ErrorHandler {
  static void handleError(BuildContext context, dynamic error) {
    if (error is PermissionDeniedException) {
      SnackBarComponent.showSnackBar(
        context, 
        "Permission Denied",
        isError: true // ngasih tau compilot kalau ini tuh error
      );
    } else {
      SnackBarComponent.showSnackBar(
        context, 
        error,
        isError: true
      );
    Navigator.of(context).pop();
    }
  }
}
// exception class itu yang menghandle error
class PermissionDeniedException implements Exception {
  final String message;
  // proses pembuatan placeholder dari sebuah exception/error
  PermissionDeniedException({this.message = ''});
  
  @override
  String toString() => message.isEmpty ? "Permission Denied" : message;
}