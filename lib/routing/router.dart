import 'package:farmboss_dashboard/main_screen.dart';
import 'package:farmboss_dashboard/pages/consumerPages/consumer_details.dart';
import 'package:farmboss_dashboard/pages/cropsPages/crop_details.dart';
import 'package:farmboss_dashboard/pages/home/home_page.dart';
import 'package:farmboss_dashboard/pages/loginPage.dart';
import 'package:farmboss_dashboard/pages/producerPages/producer_details.dart';
import 'package:farmboss_dashboard/pages/productionPages/production_details_page.dart';
import 'package:farmboss_dashboard/pages/salesPages/sales_page.dart';
import 'package:farmboss_dashboard/pages/settingsPages/settings_main_page.dart';
import 'package:farmboss_dashboard/routing/route_names.dart';
import 'package:farmboss_dashboard/welcome_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // print('generateRoute: ${settings.name}');
  switch (settings.name) {
    case HomeRoute:
      return _getPageRoute(HomePage());
    case CropDetailsRoute:
      return _getPageRoute(CropDetailsPage());
    case ConsumerDetailsRoute:
      return _getPageRoute(ConsumerDetailsPage());
    case ProducerDetailsRoute:
      return _getPageRoute(ProducerDetailsPage());
    case ProductionDetailsRoute:
      return _getPageRoute(ProductionDetailsPage());
    case SalesRoute:
      return _getPageRoute(SalesDetailsPage());
    case SettingsRoute:
      return _getPageRoute(SettingsPage());
    case WelcomeRoute:
      return _getPageRoute(WelcomeScreen());
    case LoginRoute:
      return _getPageRoute(LoginScreen());
    default:
      return _getPageRoute(HomePage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(
    builder: (context) => child,
  );
}
