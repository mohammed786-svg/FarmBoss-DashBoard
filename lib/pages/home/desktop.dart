import 'package:farmboss_dashboard/components/app_constants.dart';
import 'package:farmboss_dashboard/controllers/welcome_controller.dart';
import 'package:farmboss_dashboard/helpers/app_helpers.dart';
import 'package:farmboss_dashboard/widgets/app_styles.dart';
import 'package:farmboss_dashboard/widgets/header_text.dart';
import 'package:farmboss_dashboard/widgets/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

class HomePageDesktop extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: kSpacing,
            ),
            //padding: const EdgeInsets.symmetric(horizontal: kSpacing),

            _Header(),
            const SizedBox(height: 30.0),
            _NameSection(),
            const SizedBox(
              height: kSpacing,
            ),
            Visibility(
              visible: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                child: Row(
                  children: [
                    Card(
                      child: Container(
                        width: 500,
                        height: 400,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Production Details',
                                  style: ralewayStyle.copyWith(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.lightGreen[200]!),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          18.0) //                 <--- border radius here
                                      ),
                                  color: Colors.transparent,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.file_upload_outlined,
                                        color: Colors.lightGreen[200]!,
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        'Export',
                                        style: ralewayStyle.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.lightGreen[200]!,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
            /* _TaskInProgress(data: controller.taskInProgress),*/
          ],
        ),
      ),
    );
  }
}

class _NameSection extends StatelessWidget {
  const _NameSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello,',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Shaheed Maniyar',
                style: ralewayStyle.copyWith(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Row(
        children: [
          HeaderText(data: 'Todays Date \n${DateTime.now().formatdMMMMY()}'),
          Spacer(),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24.0),
              onTap: () {},
              child: Ink(
                decoration: BoxDecoration(
                    color: Colors.lightBlue[300],
                    borderRadius: BorderRadius.circular(24.0)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.notifications_active_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: kSpacing,
          ),
          WidgetCircularAnimator(
            size: 50,
            innerIconsSize: 3,
            outerIconsSize: 3,
            innerAnimation: Curves.easeInOutBack,
            outerAnimation: Curves.easeInOutBack,
            innerColor: Colors.deepPurple,
            outerColor: Colors.orangeAccent,
            innerAnimationSeconds: 10,
            outerAnimationSeconds: 10,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey[200]),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/images/farmer.png"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
