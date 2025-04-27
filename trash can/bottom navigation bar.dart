
//persistent_bottom_nav_bar: ^6.2.1
//import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
//late PersistentTabController _controller;

//statfull
/*@override
void initState() {
  _controller=PersistentTabController(initialIndex: 0);
  super.initState();
}*/

/* @override
 Widget build(BuildContext context) {
   List<Widget> _buildScreens() {
     return [
       MainFoodPage(),
       Center(child: Container(child: Text("1"),)),
       Center(child: Container(child: Text("2"),)),
       Center(child: Container(child: Text("3"),)),

     ];
   }
   List<PersistentBottomNavBarItem> _navBarsItems() {
     return [
       PersistentBottomNavBarItem(

         icon: Icon(CupertinoIcons.home),
         title: ("Home"),
         activeColorPrimary: CupertinoColors.activeBlue,
         inactiveColorPrimary: CupertinoColors.systemGrey,
       ),
       PersistentBottomNavBarItem(
         icon: Icon(CupertinoIcons.archivebox_fill),
         title: ("archive"),
         activeColorPrimary: CupertinoColors.activeBlue,
         inactiveColorPrimary: CupertinoColors.systemGrey,
       ),
       PersistentBottomNavBarItem(
         icon: Icon(CupertinoIcons.cart_fill),
         title: ("cart"),
         activeColorPrimary: CupertinoColors.activeBlue,
         inactiveColorPrimary: CupertinoColors.systemGrey,
       ),
       PersistentBottomNavBarItem(
         icon: Icon(CupertinoIcons.person),
         title: ("Me"),
         activeColorPrimary: CupertinoColors.activeBlue,
         inactiveColorPrimary: CupertinoColors.systemGrey,
       ),
     ];
   }
   return PersistentTabView(

     context,
     controller: _controller,
     screens: _buildScreens(),
     items: _navBarsItems(),
     handleAndroidBackButtonPress: true, // Default is true.
     resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
     stateManagement: true, // Default is true.
     hideNavigationBarWhenKeyboardAppears: true,

     //popBehaviorOnSelectedNavBarItemPress: PopActionScreensType.all,
     padding: const EdgeInsets.only(top: 8),
     backgroundColor: Colors.white,
     isVisible: true,
     animationSettings: const NavBarAnimationSettings(
       navBarItemAnimation: ItemAnimationSettings( // Navigation Bar's items animation properties.
         duration: Duration(milliseconds: 100),
         curve: Curves.ease,
       ),
       screenTransitionAnimation: ScreenTransitionAnimationSettings( // Screen transition animation on change of selected tab.
         animateTabTransition: true,
         duration: Duration(milliseconds: 200),
         screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
       ),
     ),
     confineToSafeArea: true,
     navBarHeight: kBottomNavigationBarHeight,
     navBarStyle: NavBarStyle.style5,//_navBarStyle, // Choose the nav bar style with this property
   );
 }*/
