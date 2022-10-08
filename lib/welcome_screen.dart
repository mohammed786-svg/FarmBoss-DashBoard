library dashboard;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:farmboss_dashboard/components/app_constants.dart';
import 'package:farmboss_dashboard/components/selection_button.dart';
import 'package:farmboss_dashboard/components/user_profile.dart';
import 'package:farmboss_dashboard/constants.dart';
import 'package:farmboss_dashboard/controllers/welcome_controller.dart';

import 'package:farmboss_dashboard/helpers/app_helpers.dart';
import 'package:farmboss_dashboard/pages/salesPages/sales_page.dart';
import 'package:farmboss_dashboard/providers/app_provider.dart';
import 'package:farmboss_dashboard/routing/route_names.dart';
import 'package:farmboss_dashboard/routing/router.dart';
import 'package:farmboss_dashboard/services/locator.dart';
import 'package:farmboss_dashboard/services/navigation_service.dart';
import 'package:farmboss_dashboard/widgets/header_text.dart';
import 'package:farmboss_dashboard/widgets/responsive_builder.dart';
import 'package:farmboss_dashboard/widgets/search_field.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part './components/main_menu.dart';

//final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

class WelcomeScreen extends GetView<WelcomeController> {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: ResponsiveBuilder.isDesktop(context)
            ? null
            : Drawer(
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: _buildSideBar(context),
                  ),
                ),
              ),
        key: controller.scafoldKey,
        body: ResponsiveBuilder(
          mobileBuilder: (context, constraints) {
            return Center(
              child: Container(
                color: Colors.green,
                child: const Text(
                    "This DashBoard is Designed for Desktop/Tablet Mode Only "),
              ),
            );
          },
          tabletBuilder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Todo:Create menu button here combya

                Padding(
                  padding: const EdgeInsets.only(right: kSpacing / 2),
                  child: IconButton(
                      onPressed: () {
                        controller.openDrawer();
                      },
                      icon: Icon(Icons.menu)),
                ),
                Flexible(
                  flex: 10,
                  child: Column(
                    children: [
                      Expanded(
                        child: Navigator(
                          key: locator<NavigationService>().navigatorKey,
                          onGenerateRoute: generateRoute,
                          initialRoute: HomeRoute,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
          desktopBuilder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: constraints.maxWidth > 1100 ? 3 : 3,
                    child: _buildSideBar(context)),
                Flexible(
                  flex: constraints.maxWidth > 1100 ? 10 : 9,
                  child: Column(
                    children: [
                      Expanded(
                        child: Navigator(
                          key: locator<NavigationService>().navigatorKey,
                          onGenerateRoute: generateRoute,
                          initialRoute: HomeRoute,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        )
        /*Row(
        children: [
          Flexible(
            flex: 3,
            child: _buildSideBar(context)
          ),

          Flexible(
            flex: 10,
            child: Column(
              children: [

                Expanded(
                  child: Navigator(
                    key: locator<NavigationService>().navigatorKey,
                    onGenerateRoute: generateRoute,
                    initialRoute: HomeRoute,
                  ),
                )
              ],
            ),
          ),

          */

        /*Flexible(
            flex: 4,
            child: _buildCalendarContent()
          ),*/ /*
        ],
      ),*/
        );
  }

  Widget _buildSideBar(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // UserProfile(
            //     data: controller.dataProfile,
            //     onPressed: controller.onPressedProfile),
            Center(
              child: Image.asset(
                'assets/images/b_logo.jpg',
                height: 200,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            _MainMenu(onSelected: controller.OnSelectedMainMenu),
            //_MainMenu(),
            ///indent is startmargin ,endintent is end margin
            const Divider(
              indent: 20,
              thickness: 1,
              endIndent: 20,
              height: 40,
              color: Colors.white,
            ),

            /*_Member(member: controller.member),
            const SizedBox(height: kSpacing),*/
            const Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("@FarmBoss Licence",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black26)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateRole() {
    return Container();
  }

  Widget _buildTaskContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        children: [
          SizedBox(
            height: kSpacing,
          ),
          Search_Field(
            onSearch: controller.onSearchUser,
            hintText: "Search Users",
          ),
          SizedBox(
            height: kSpacing,
          ),
          Row(
            children: [
              HeaderText(data: DateTime.now().formatdMMMMY()),
              Spacer(),
            ],
          ),
          const SizedBox(height: kSpacing),
          /* _TaskInProgress(data: controller.taskInProgress),*/
        ],
      ),
    );
  }

  Widget _buildCalendarContent() {
    return Container();
  }
}
