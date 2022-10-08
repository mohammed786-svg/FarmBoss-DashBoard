import 'package:flutter/material.dart';

enum DisplayedPage {
  HOME,
  CROPDETAILS,
  CONSUMERS,
  PRODUCERS,
  SALES,
  PRODUCTION,
  SETTINGS,
  LOGOUT
}

class AppProvider with ChangeNotifier {
  late DisplayedPage currentPage;

  AppProvider.init() {
    changeCurrentPage(DisplayedPage.HOME);
  }

  changeCurrentPage(DisplayedPage newPage) {
    currentPage = newPage;
    notifyListeners();
  }
}
