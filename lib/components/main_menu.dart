part of dashboard;

class _MainMenu extends StatelessWidget {
  const _MainMenu({Key? key, required this.onSelected}) : super(key: key);
  final Function(int index, SelectionButtonData value) onSelected;

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    return SelectionButton(
      data: [
        SelectionButtonData(
          activeIcon: EvaIcons.home,
          icon: EvaIcons.homeOutline,
          label: "Home",
          active: appProvider.currentPage == DisplayedPage.HOME,
          onTap: () {
            appProvider.changeCurrentPage(DisplayedPage.HOME);
            locator<NavigationService>().navigateTo(HomeRoute);
          },
        ),
        SelectionButtonData(
          activeIcon: Icons.add,
          icon: Icons.add_outlined,
          label: "Crop Details",
          active: appProvider.currentPage == DisplayedPage.CROPDETAILS,
          onTap: () {
            appProvider.changeCurrentPage(DisplayedPage.CROPDETAILS);
            locator<NavigationService>().navigateTo(CropDetailsRoute);
          },
        ),
        SelectionButtonData(
          activeIcon: Icons.person_pin_circle,
          icon: Icons.person_pin_circle_outlined,
          label: "Consumers",
          active: appProvider.currentPage == DisplayedPage.CONSUMERS,
          onTap: () {
            appProvider.changeCurrentPage(DisplayedPage.CONSUMERS);
            locator<NavigationService>().navigateTo(ConsumerDetailsRoute);
          },
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.personDone,
          icon: Icons.person_outline,
          label: "Producers ",
          active: appProvider.currentPage == DisplayedPage.PRODUCERS,
          onTap: () {
            appProvider.changeCurrentPage(DisplayedPage.PRODUCERS);
            locator<NavigationService>().navigateTo(ProducerDetailsRoute);
          },
        ),
        SelectionButtonData(
          activeIcon: Icons.addchart,
          icon: Icons.addchart_outlined,
          label: "Sales",
          active: appProvider.currentPage == DisplayedPage.SALES,
          onTap: () {
            appProvider.changeCurrentPage(DisplayedPage.SALES);
            locator<NavigationService>().navigateTo(SalesRoute);
          },
        ),
        SelectionButtonData(
          activeIcon: Icons.create_new_folder,
          icon: Icons.create_new_folder_outlined,
          label: "Production Details",
          active: appProvider.currentPage == DisplayedPage.PRODUCTION,
          onTap: () {
            appProvider.changeCurrentPage(DisplayedPage.PRODUCTION);
            locator<NavigationService>().navigateTo(ProductionDetailsRoute);
          },
        ),
        // SelectionButtonData(
        //   activeIcon: EvaIcons.bell,
        //   icon: EvaIcons.bellOutline,
        //   label: "Notifications",
        //   totalNotif: 100,
        //   active: appProvider.currentPage == DisplayedPage.NOTIFICATIONS,
        //   onTap: () {
        //     appProvider.changeCurrentPage(DisplayedPage.HOME);
        //     locator<NavigationService>().navigateTo(HomeRoute);
        //   },
        // ),
        SelectionButtonData(
          activeIcon: EvaIcons.settings,
          icon: EvaIcons.settingsOutline,
          label: "Settings",
          active: appProvider.currentPage == DisplayedPage.SETTINGS,
          onTap: () {
            appProvider.changeCurrentPage(DisplayedPage.SETTINGS);
            locator<NavigationService>().navigateTo(SettingsRoute);
          },
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.logOut,
          icon: EvaIcons.logOutOutline,
          label: "Log Out",
          active: appProvider.currentPage == DisplayedPage.LOGOUT,
          onTap: () {
            appProvider.changeCurrentPage(DisplayedPage.LOGOUT);
            locator<NavigationService>().navigateTo(HomeRoute);
          },
        )
      ],
      onSelected: onSelected,
    );
  }
}
