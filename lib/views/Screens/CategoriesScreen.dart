// ignore: file_names

import 'package:clientecommerce/AppRouter/AppRouter.dart';
import 'package:clientecommerce/providers/authProvider.dart';
import 'package:clientecommerce/providers/fireStoreProvider.dart';
import 'package:clientecommerce/views/widgets/CategoryWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // int _seselectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          ElevatedButton(
              onPressed: () async {

              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              child: Icon(Icons.search))
        ],
        title: Text(
          "Categories",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
        // automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            // selectedIndex: _seselectedIndex,
            activeColor: Colors.white,
            color: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            padding: EdgeInsets.all(8),
            // onTabChange: (index) {
            //   setState(() {
            //     _seselectedIndex = index;
            //   });
            //   AppRoute.pushScreenNav(index);
            // },
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
                icon: Icons.notifications,
                gap: 8,
                text: "favorites",
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
      body: Container(
        margin: EdgeInsets.only(top: 10.h, left: 0.w),
        child: Column(
          children: [
            SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                          // padding: EdgeInsets.only(bottom: 30.h),
                          height: 610.h,
                          child: Provider.of<FireStoreProvider>(context)
                                      .categories ==
                                  null
                              ? Lottie.asset('assets/images/empty.json')
                              : ListView.builder(
                                  itemCount:
                                      Provider.of<FireStoreProvider>(context)
                                          .categories
                                          .length,
                                  itemBuilder: (context, index) {
                                    return CatWidget(
                                        Provider.of<FireStoreProvider>(context)
                                            .categories[index],
                                        index);
                                  })),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
