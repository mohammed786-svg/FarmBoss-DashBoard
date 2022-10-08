import 'package:farmboss_dashboard/components/chart.dart';
import 'package:farmboss_dashboard/components/header.dart';
import 'package:farmboss_dashboard/constants.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(),
            const SizedBox(
              height: defaultPadding,
            ),
            Row(
              children: [
                Expanded(
                    flex: 5,
                    child: Container(
                      height: 500,
                      color: secondaryColor,
                    )),
                const SizedBox(
                  width: defaultPadding,
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      height: 500,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Statistics',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          Chart()
                        ],
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
