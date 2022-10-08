import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FarmGlb {
  static String endPoint = "http://101.53.149.34:4443/";
  static String instid = "292";
  static String secdesc = "8TH(C)";
  static String batchid = "581";
  static String teacherid = "3171";
  static String usrid = "112333";
  static String classid = "596";
  static String subjectid = "5263";

  static String getDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd MMM yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static String getTodaysDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static void showToast(String msg) {
    Get.snackbar('Alert', msg, snackPosition: SnackPosition.BOTTOM);
  }

  static void showSnackBar(BuildContext context, String text) {
    Get.snackbar('Alert', text, snackPosition: SnackPosition.BOTTOM);
  }

  static void showSnackBarScaffold(
      GlobalKey<ScaffoldState> context, String text) {
    Get.snackbar('Alert', text, snackPosition: SnackPosition.BOTTOM);
  }
}
