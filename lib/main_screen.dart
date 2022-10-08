import 'package:farmboss_dashboard/components/side_menu.dart';
import 'package:farmboss_dashboard/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(child: SideMenu()),
          Expanded(flex: 5, child: DashboardScreen()),
        ],
      )),
    );
  }
}
