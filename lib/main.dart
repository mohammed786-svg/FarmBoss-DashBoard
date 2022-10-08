import 'package:farmboss_dashboard/controllers/welcome_controller.dart';
import 'package:farmboss_dashboard/providers/app_provider.dart';
import 'package:farmboss_dashboard/routing/route_names.dart';
import 'package:farmboss_dashboard/routing/router.dart';
import 'package:farmboss_dashboard/services/locator.dart';
import 'package:farmboss_dashboard/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  Get.put(WelcomeController());
  // runApp(const MyApp());
  setupLocator();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AppProvider.init()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FarmBoss Dashboard',
      initialRoute: LoginRoute,
      onGenerateRoute: generateRoute,
    );
  }
}
