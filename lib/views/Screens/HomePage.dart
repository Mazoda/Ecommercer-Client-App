import 'package:clientecommerce/AppRouter/AppRouter.dart';
import 'package:clientecommerce/models/Category.dart';
import 'package:clientecommerce/models/Product.dart';
import 'package:clientecommerce/providers/authProvider.dart';
import 'package:clientecommerce/providers/fireStoreProvider.dart';
import 'package:clientecommerce/views/Screens/CategoriesScreen.dart';
import 'package:clientecommerce/views/Screens/CartScreen.dart';
import 'package:clientecommerce/views/Screens/FavoritesScreen.dart';
import 'package:clientecommerce/views/Screens/ProfileScreen.dart';
import 'package:clientecommerce/views/widgets/OffersWidget.dart';
import 'package:clientecommerce/views/widgets/ProductWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class HomePageSCreen extends StatefulWidget {
  const HomePageSCreen({Key? key}) : super(key: key);

  @override
  State<HomePageSCreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageSCreen> {
  @override
  Widget build(BuildContext context) {
    // Provider.of<FireStoreProvider>(context, listen: false).userDetails();
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: GNav(
              onTabChange: (value) {
                Provider.of<FireStoreProvider>(context,listen: false)
                    .changeSelecetedIndex(value);
              },
              selectedIndex:
                  Provider.of<FireStoreProvider>(context).selectedIndex,
              backgroundColor: Colors.black,
              activeColor: Colors.white,
              color: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              padding: EdgeInsets.all(8),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  gap: 8,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.shopping_cart,
                  gap: 8,
                  text: "cart",
                ),
                GButton(
                  icon: Icons.favorite,
                  gap: 8,
                  text: "Favorites",
                ),
                GButton(
                  icon: Icons.person,
                  gap: 8,
                  text: "Profile",
                )
              ],
            ),
          ),
        ),
        body : Provider.of<FireStoreProvider>(context).currentWidget);
  }
}
