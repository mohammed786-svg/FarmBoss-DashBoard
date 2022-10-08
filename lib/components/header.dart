import 'package:farmboss_dashboard/constants.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Dashboard',
          style: Theme.of(context).textTheme.headline6,
        ),
        const Spacer(
          flex: 2,
        ),
        const Expanded(child: SearchField()),
        const ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/farmer_logo.png',
            height: 38,
          ),
          const Padding(
            padding: EdgeInsets.all(defaultPadding / 2),
            child: Text(
              'Shaheed',
            ),
          ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: 'Search',
          fillColor: secondaryColor,
          filled: true,
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          suffixIcon: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(defaultPadding * 0.75),
              margin:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(Icons.search),
            ),
          )),
    );
  }
}
