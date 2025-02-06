import 'package:attendance/UI/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Size size;
  final TextEditingController namaController;
  final TextEditingController formController;
  final TextEditingController toController;
  final String dropValueCategories;
  final CollectionReference dataCollection;

  const SubmitButton({
    super.key, 
    required this.size, 
    required this.namaController, 
    required this.formController,
    required this.toController, 
    required this.dropValueCategories, 
    required this.dataCollection
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: size.width,
        child: ElevatedButton(
          onPressed: () => _submitHandler(context), 
          child: const Text("submit")
        ),
      ),
    );
  }
  void _submitHandler(BuildContext context) { // Fuction Utama
    if (_isFormValid()) {
      _submitForm(context);
    } else {
      _showSnackBar(
        context, 
        "Please fill the form", 
        Icons.warning_amber_rounded, 
        Colors.white
      );
    }
  }

  bool _isFormValid() { // bikin dropdown
    return namaController.text.isNotEmpty && 
    dropValueCategories != "Please Choose:" && 
    formController.text.isNotEmpty && 
    toController.text.isNotEmpty;
  }

  void _showSnackBar(BuildContext context, String message, IconData icon, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              message, 
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: color,
        shape: const StadiumBorder(),
        behavior: SnackBarBehavior.floating,
      )
    );
  }

  void _showLoaderDialog(BuildContext context) {
    showDialog(
      context: context, 
      barrierDismissible: false, // Mencegah pengguna menutup dialog dengan mengetuk di luar area dialog (true)
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const Text("Please wait..."),
              )
            ],
          ),
        );
      }
    );
  }

  Future<void> _submitForm(BuildContext context) async {
    _showLoaderDialog(context);
    try {
      await dataCollection.add({
        'address' : '-',
        'name' : namaController,
        'description' : dropValueCategories,
        'timestamp' : '${formController.text} : ${formController.text}'
      }); 
      Navigator.of(context).pop();

      _showSnackBar(
        context, 
        "Successfully submit the form", 
        Icons.check_circle_outline, 
        Colors.orangeAccent
      );
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => const HomeScreen()
        )
      );
    } catch (e) {
      Navigator.of(context).pop();
      _showSnackBar(
        context, 
        "An error occured: $e", 
        Icons.error_outline, 
        Colors.blueGrey
      );
    }
  }
}