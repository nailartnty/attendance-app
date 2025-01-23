import 'package:attendance/UI/attend/attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope( // untuk pop up yang muncul ketika keluar dari aplikasi
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        _onWillPop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // _buildMenuItem(
                //   context, 
                //   imagePath: "/assets/images/ic_atten.png", 
                //   label: "Attendance Report", 
                //   destination: const AttendanceScreen()
                // ),
                // const SizedBox(height: 40), 
                // _buildMenuItem(
                //   context, 
                //   imagePath: "assets/images/ic_permition.png", 
                //   label: "Permission Report", 
                //   destination: const AttendanceScreen() 
                // ),               
                // const SizedBox(height: 40), 
                // _buildMenuItem(
                //   context, 
                //   imagePath: "assets/images/history.png", 
                //   label: "", 
                //   destination: const AttendanceScreen()
                // )               
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    /* ini adalah parameter yang harus diisi */
    BuildContext context, {
      required String imagePath,
      required String label,
      required Widget destination
    }) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Expanded(
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
          },
          // untuk menambahkan image
          child: Column(
            children: [
              Image(
                image: AssetImage(imagePath),
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 20, 
                  color: Colors.black, 
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  // buat confirm exit
  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog( // 
      barrierDismissible: false, // ini tuh buat dialog tidak bisa ditutup dengan sentuhan apapun
      context: context,
      builder: (context) =>
      // udah masuk uinya
       AlertDialog(
        title: const Text(
          "information",
          style: TextStyle(
            fontSize: 20, 
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
        content: const Text(
          "Are you sure you want to exit the application?",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          )
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), 
            child: const Text(
              "No",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black
              ),
            )
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(), // untuk keluar dari aplikasi
            child: const Text(
              "Yes",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black
              ),
            )
          )
        ],
      )
      /* ini adalah default value ketika semua kode yang ada di 
       blokalert Dialog tidak tereksekusi karena beberapa hal */
    )) ?? false;
  }
}