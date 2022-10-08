import 'package:farmboss_dashboard/components/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

class UserProfileData {
  final ImageProvider image;
  final String name;
  final String jobDesk;
  final String orgName;
  const UserProfileData(
      {required this.image,
      required this.name,
      required this.jobDesk,
      required this.orgName});
}

class UserProfile extends StatelessWidget {
  const UserProfile({required this.data, required this.onPressed, Key? key})
      : super(key: key);

  final UserProfileData data;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(kBorderRadius),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/farme.png",
                    width: 120,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    "assets/images/logo.png",
                    width: 40,
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),
              */

              Row(
                children: [
                  _buildImage(),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    //, _buildJobDesk(), _buildOrgName()
                    children: [
                      _buildName(),
                      const SizedBox(
                        height: 5.0,
                      ),
                      _buildJobDesk()
                    ],
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return WidgetCircularAnimator(
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
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.grey[200]),
        child: CircleAvatar(
          radius: 25,
          backgroundImage: data.image,
        ),
      ),
    );
    /*return CircleAvatar(
      radius: 25,
      backgroundImage: data.image,
    );*/
  }

  Widget _buildName() {
    return Text(
      data.name,
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildJobDesk() {
    return Text(
      data.jobDesk,
      style: const TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildOrgName() {
    return Text(
      data.orgName,
      style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey[350]),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
