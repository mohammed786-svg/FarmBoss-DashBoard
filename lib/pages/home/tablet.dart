import 'package:farmboss_dashboard/widgets/page_header.dart';
import 'package:flutter/material.dart';

class HomePageTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PageHeader(
          text: 'DASHBOARD',
        ),
      ],
    );
  }
}
