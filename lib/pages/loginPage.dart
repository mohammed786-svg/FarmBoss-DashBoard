import 'dart:convert';

import 'package:farmboss_dashboard/routing/route_names.dart';
import 'package:farmboss_dashboard/utils/app_colors.dart';
import 'package:farmboss_dashboard/widgets/app_styles.dart';
import 'package:farmboss_dashboard/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SizedBox(
        width: width,
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsiveWidget.isSmallScreen(context)
                ? const SizedBox()
                : Expanded(
                    child: Container(
                      color: Colors.transparent,
                      height: height,
                    ),
                  ),
            _FormUI(height: height, width: width),
          ],
        ),
      ),
    );
  }
}

class _FormUI extends StatelessWidget {
  const _FormUI({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    String title;

    return Expanded(
      child: Container(
          color: AppColors.backColor,
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveWidget.isSmallScreen(context)
                  ? height * 0.032
                  : height * 0.12),
          height: height,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.2,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Let\'s',
                      style: ralewayStyle.copyWith(
                        fontSize: 25.0,
                        color: AppColors.blueDarkColor,
                        fontWeight: FontWeight.normal,
                      )),
                  TextSpan(
                      text: ' Log In👇',
                      style: ralewayStyle.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.blueDarkColor,
                        fontSize: 25.0,
                      ))
                ])),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  'Hey,Enter your details to get login \ninto your account',
                  style: ralewayStyle.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(
                  height: height * 0.064,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Mobile Number',
                    style: ralewayStyle.copyWith(
                      fontSize: 12.0,
                      color: AppColors.blueDarkColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Container(
                  height: 50.0,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: AppColors.whiteColor,
                  ),
                  child: TextFormField(
                    style: ralewayStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.blueDarkColor,
                        fontSize: 12.0),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.phone),
                        ),
                        contentPadding: EdgeInsets.only(top: 16.0),
                        hintText: 'Enter your mobile number',
                        hintStyle: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor.withOpacity(0.5),
                            fontSize: 12.0)),
                  ),
                ),
                SizedBox(
                  height: height * 0.014,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Password',
                    style: ralewayStyle.copyWith(
                      fontSize: 12.0,
                      color: AppColors.blueDarkColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Container(
                  height: 50.0,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: AppColors.whiteColor,
                  ),
                  child: TextFormField(
                    style: ralewayStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.blueDarkColor,
                        fontSize: 12.0),
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: Icon(Icons.remove_red_eye)),
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.security),
                        ),
                        contentPadding: EdgeInsets.only(top: 16.0),
                        hintText: 'Enter Your Password',
                        hintStyle: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor.withOpacity(0.5),
                            fontSize: 12.0)),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: ralewayStyle.copyWith(
                          fontSize: 12.0,
                          color: AppColors.mainBlueColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, WelcomeRoute);
                    },
                    borderRadius: BorderRadius.circular(16.0),
                    child: Ink(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70.0, vertical: 18.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: AppColors.mainBlueColor),
                      child: Text(
                        'Login In',
                        style: ralewayStyle.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.whiteColor,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
