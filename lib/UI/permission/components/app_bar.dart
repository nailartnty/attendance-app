import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.blueAccent,
    leading: IconButton(
      onPressed: () => Navigator.of(context).pop(), 
      icon: const Icon(Icons.arrow_back_ios)
    ),
    title: Text(
      "Permission Request Menu",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),
    ),
  );
}