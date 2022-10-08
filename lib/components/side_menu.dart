import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset('assets/images/farmer_logo.png'),
            ),
            DrawerListTile(title: 'Dashboard', icon: Icons.home, press: () {}),
            DrawerListTile(
                title: 'Transactions',
                icon: Icons.currency_exchange,
                press: () {}),
            DrawerListTile(
                title: 'Add Crop Details',
                icon: Icons.filter_vintage_rounded,
                press: () {}),
            DrawerListTile(
                title: 'Consumers Details',
                icon: Icons.person_pin_outlined,
                press: () {}),
            DrawerListTile(
                title: 'Producers Details',
                icon: Icons.person_pin,
                press: () {}),
            DrawerListTile(
                title: 'Settings', icon: Icons.settings, press: () {}),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0.0,
      onTap: press,
      leading: Icon(
        icon,
        color: Colors.white30,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
