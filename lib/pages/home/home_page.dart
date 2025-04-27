import 'package:ecoomerce_dbestech/pages/account/account_page.dart';
import 'package:ecoomerce_dbestech/pages/auth/sign_up.dart';
import 'package:ecoomerce_dbestech/pages/cart/cart_history.dart';
import 'package:ecoomerce_dbestech/pages/home/mainFoodPage.dart';
import 'package:ecoomerce_dbestech/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 int _selectedPage =0;

  List<Widget> pages =[
    MainFoodPage(),
   SignUp(),
  CartHistory(),
    AccountPage()
 ];
void onTap(int index){

  setState(() {
    _selectedPage=index;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTap,
        items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
        icon: Icon(Icons.home),
    label: 'Home',

    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.archive),
    label: 'archive',

    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.shopping_cart),
    label: 'Cart',

    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'Me',

    ),
    ],
    currentIndex: _selectedPage,
    selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.grey,

      ),
    );
  }



}
