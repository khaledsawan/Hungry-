import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shop_delivery_system/screen/cart/cart_history_page.dart';
import 'package:shop_delivery_system/screen/main/main_food_page.dart';
import 'package:shop_delivery_system/screen/setting/setting_page.dart';
import 'package:shop_delivery_system/utils/colors.dart';
import '../user profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const MainFoodPage(),
      const Center(child: Text('Archive')),
      const CartHistoryPage(),
      const ProfilePage(),
       SettingPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.yellowColor,
      ),

      PersistentBottomNavBarItem(
        icon:const Icon(CupertinoIcons.archivebox_fill),
        title: ("Archie"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.yellowColor,
      ),
      PersistentBottomNavBarItem(
        icon:const Icon(CupertinoIcons.cart),
        title: ("cart"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.yellowColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("ME"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.yellowColor,
      ),
      PersistentBottomNavBarItem(
        icon:const Icon(CupertinoIcons.settings_solid),
        title: ("setting"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.yellowColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return
       PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: AppColors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset:
            true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows:
            true,
        decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: AppColors.white,
            boxShadow: [
              const BoxShadow(
                color: AppColors.yellowColor,
                offset: Offset(
                  0.1,
                  0.1,
                ),
                blurRadius: 1.0,
                spreadRadius: 1.0,
              )
            ]),
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
        navBarStyle: NavBarStyle
            .style12,
      );
  }
}
