import 'package:farmboss_dashboard/components/selection_button.dart';
import 'package:farmboss_dashboard/components/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  final UserProfileData dataProfile = UserProfileData(
      image: AssetImage("assets/images/farmer.png"),
      name: 'Shaheed',
      jobDesk: 'Super Admin',
      orgName: 'organization Name');

  final member = ["Avril Kimberly", "Michael Greg"];
  final scafoldKey = GlobalKey<ScaffoldState>();

  void onPressedProfile() {
    print("profile Pressed:$dataProfile");
    dataProfile;
    update();
  }

  void OrganizationChanged(String orgName) {}

  void OnSelectedMainMenu(int index, SelectionButtonData value) {
    // print("value.label${value.label}  index==$index");
  }

  void openDrawer() {
    if (scafoldKey.currentState != null) {
      scafoldKey.currentState!.openDrawer();
    }
  }

  void onSearchUser(String value) {
    print(value);
  }
}
