import 'package:intl/intl.dart';

// mau mendapatkan data waktu real-time dari intl library
void setDateTime(Function(String, String, String) onDateTimeSet) {
  var dateNow = DateTime.now();
  var dateFormat = DateFormat('dd mm yyyy');
  var dateTime = DateFormat('hh:mm:ss');

  String date = dateFormat.format(dateNow);
  String time = dateTime.format(dateNow);
  String currentDate = '$date | $time';

  onDateTimeSet(date, time, currentDate);
}

// kalu udah dapat datanya 
void setAttendStatus(Function(String) onStatusSet) {
  var dateNow = DateTime.now();
  // int.parse() untuk mengubah int jadi string
  var hour = int.parse(DateFormat('hh').format(dateNow)); // format 24 jam 2 digit 
  var minute = int.parse(DateFormat('mm').format(dateNow));
  
  String setAttendStatus;
  if (hour < 7 || (hour == 7 && minute == 00)) {
    setAttendStatus = "Attend";
  } else if (hour > 7 || (hour == 7 && minute >= 01)) {
    setAttendStatus = "Late";
  } else {
    setAttendStatus = "Absent";
  }

  onStatusSet(setAttendStatus);
}