import 'package:farmboss_dashboard/controllers/welcome_controller.dart';
import 'package:farmboss_dashboard/pages/home/desktop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    print("coming here");
    return Scaffold(
        //SizeConstraintWidget(child: HomePageDesktop()),
        body: HomePageDesktop());
  }
}

/*
return Scaffold(
     key: controller.scafoldKey,
     body: ResponsiveBuilder(
       mobileBuilder: (context,constraints){
         return HomePageMobile();
       },
       tabletBuilder: (context,constraints){
         return HomePageTablet();
       },
       desktopBuilder: (context,constraints){
         return SizeConstraintWidget(child: HomePageDesktop());
       },
     ),
   );
 */

/*return  ScreenTypeLayout(
breakpoints: const ScreenBreakpoints(
tablet: 1100,
desktop: 1260,
watch: 600
),
mobile: HomePageMobile(),
tablet: HomePageTablet(),
// tablet: SizeConstraintWidget(child: HomePageDesktop()),
desktop: SizeConstraintWidget(child: HomePageDesktop()),
);*/
