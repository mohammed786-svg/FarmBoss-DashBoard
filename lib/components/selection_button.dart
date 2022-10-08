import 'package:farmboss_dashboard/components/app_constants.dart';
import 'package:farmboss_dashboard/providers/app_provider.dart';
import 'package:farmboss_dashboard/routing/route_names.dart';
import 'package:farmboss_dashboard/services/locator.dart';
import 'package:farmboss_dashboard/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SelectionButtonData {
  final IconData activeIcon;
  final IconData icon;
  final String label;
  final int? totalNotif;
  final bool active;
  final Function() onTap;

  SelectionButtonData(
      {required this.activeIcon,
      required this.icon,
      required this.label,
      this.totalNotif,
      required this.active,
      required this.onTap});
}

class SelectionButton extends StatefulWidget {
  const SelectionButton({
    this.initialSelected = 0,
    required this.data,
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  final int initialSelected;
  final List<SelectionButtonData> data;
  final Function(int index, SelectionButtonData value) onSelected;

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  late int selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initialSelected;
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    return Column(
      children: widget.data.asMap().entries.map((e) {
        final index = e.key;
        final data = e.value;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _Button(
            selected: selected == index,
            onPressed: () {
              widget.onSelected(index, data);
              setState(() {
                selected = index;
                if (index == 0) {
                  appProvider.changeCurrentPage(DisplayedPage.HOME);
                  locator<NavigationService>().navigateTo(HomeRoute);
                } else if (index == 1) {
                  appProvider.changeCurrentPage(DisplayedPage.CROPDETAILS);
                  locator<NavigationService>().navigateTo(CropDetailsRoute);
                } else if (index == 2) {
                  appProvider.changeCurrentPage(DisplayedPage.CONSUMERS);
                  locator<NavigationService>().navigateTo(ConsumerDetailsRoute);
                } else if (index == 3) {
                  appProvider.changeCurrentPage(DisplayedPage.PRODUCERS);
                  locator<NavigationService>().navigateTo(ProducerDetailsRoute);
                } else if (index == 4) {
                  appProvider.changeCurrentPage(DisplayedPage.SALES);
                  locator<NavigationService>().navigateTo(SalesRoute);
                } else if (index == 5) {
                  appProvider.changeCurrentPage(DisplayedPage.PRODUCTION);
                  locator<NavigationService>()
                      .navigateTo(ProductionDetailsRoute);
                } else if (index == 6) {
                  appProvider.changeCurrentPage(DisplayedPage.SETTINGS);
                  locator<NavigationService>().navigateTo(HomeRoute);
                }
              });
            },
            data: data,
          ),
        );
      }).toList(),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.selected,
    required this.data,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final bool selected;
  final SelectionButtonData data;
  final Function() onPressed;

  /*
  Material(
      color:
      (!selected) ? null : Theme.of(context).primaryColor.withOpacity(.1),
      borderRadius: BorderRadius.circular(kBorderRadius),
   */
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            _buildIcon(),
            const SizedBox(width: kSpacing / 2),
            Expanded(child: _buildLabel()),
            if (selected)
              Icon(
                Icons.arrow_right,
                color: Colors.green[900],
              ),
            SizedBox(
              width: 3,
            ),
            if (data.totalNotif != null)
              Padding(
                padding: const EdgeInsets.only(left: kSpacing / 2),
                child: _buildNotif(),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Icon(
      (!selected) ? data.icon : data.activeIcon,
      size: 20,
      color: (!selected) ? kFontColorPallets[1] : Colors.green[900],
    );
  }
  /*
  color: (!selected)
          ? kFontColorPallets[1]
          : Theme.of(Get.context!).primaryColor,
   */

  Widget _buildLabel() {
    return Text(
      data.label,
      style: TextStyle(
        color: (!selected) ? kFontColorPallets[1] : Colors.green[900],
        fontWeight: FontWeight.bold,
        letterSpacing: .8,
        fontSize: 14,
      ),
    );
  }

  Widget _buildNotif() {
    return (data.totalNotif == null || data.totalNotif! <= 0)
        ? Container()
        : Container(
            width: 20,
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 40, 243, 9),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              (data.totalNotif! >= 100) ? "99+" : "${data.totalNotif}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          );
  }
}
