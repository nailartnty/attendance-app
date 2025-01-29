import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Container buildSubmitButton(BuildContext context, Size, XFile? image, TextEditingController controllerName, String address, String status, String timeStamp) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.all(10),
    child: Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: Size.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blueAccent,
          child: InkWell(
            splashColor: Colors.blue,
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              if (image == null || controllerName.text.isEmpty) {
                showSnackBar();
              } else {
                
              }
            },
          ),
        ),
      ),
    ),
  );
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.white),
          SizedBox(width: 10),
          Text(
           message,
           style: TextStyle(
            fontSize: 16,
            color: Colors.white
           ),
          )
        ],
      ),
      backgroundColor: Colors.blueGrey,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
    )
  );
}