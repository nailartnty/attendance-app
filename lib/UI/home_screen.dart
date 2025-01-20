import 'package:attendance/UI/attend/attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
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
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AttendanceScreen()));
                      },
                      // untuk menambahkan image
                      child: const Column(
                        children: [
                          Image(
                            image: AssetImage('assets/'),
                            height: 100,
                            width: 100,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Attendance Report",
                            style: TextStyle(
                              fontSize: 20, 
                              color: Colors.black, 
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 40),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
  // buat confirm exit
  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
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
    ));
  }
}