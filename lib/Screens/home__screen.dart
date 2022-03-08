import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vyam_vandor/Screens/Tabs/Insights/insights.dart';
import 'package:vyam_vandor/Screens/Tabs/dashboard_tab.dart';
import 'package:vyam_vandor/Screens/Tabs/home_tab.dart';
import 'package:vyam_vandor/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "Assets/Images/home_icon.png",
          height: 20,
          width: 20,
          color: AppColors.bottomNaVBarTextColor,
        ),
        title: ('Home'),
        contentPadding: 0,
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "Assets/Images/insight.png",
          height: 20,
          width: 20,
          color: AppColors.bottomNaVBarTextColor,
        ),
        title: ('Insights'),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "Assets/Images/dashboard.png",
          // height: 30,
          // width: 30,
          color: AppColors.bottomNaVBarTextColor,
        ),
        iconSize: 40,
        title: ('Dashboard'),
        //TODO: Change Bottom nav Bar TextStyle
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      const HomeTab(),
      const InsightsTab(),
      DashBoardScreen(),
    ];
  }

  PersistentTabController? _persistentTabController;

  var status = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF4F4F4),
        bottomNavigationBar: PersistentTabView(
          context,
          controller: _persistentTabController,
          navBarHeight: 65,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardShows: true,
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style3,
        ),
      ),
    );
  }
}
