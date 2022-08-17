import 'package:clientecommerce/AppRouter/AppRouter.dart';
import 'package:clientecommerce/models/AppUser.dart';
import 'package:clientecommerce/models/Product.dart';
import 'package:clientecommerce/providers/authProvider.dart';
import 'package:clientecommerce/providers/fireStoreProvider.dart';
import 'package:clientecommerce/views/Screens/CategoriesScreen.dart';
import 'package:clientecommerce/views/Screens/ProfileScreen.dart';
import 'package:clientecommerce/views/widgets/OffersWidget.dart';
import 'package:clientecommerce/views/widgets/ProductWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              margin: EdgeInsets.only(left: 18.w, top: 50.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            await Provider.of<AuthProvider>(context,
                                    listen: false)
                                .signOut();
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.white)))),
                          child: Icon(Icons.exit_to_app)),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage (
                            Provider.of<FireStoreProvider>(context)
                                .appUser!
                                .imageUrl!),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Welcome,",
                        style: GoogleFonts.poppins(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("our Fashion App",
                        style: GoogleFonts.poppins(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600)),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 300.w,
                        child: TextField(
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: "Search",
                              fillColor: Color.fromARGB(255, 231, 229, 229),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(40))),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () async {
      
                        },
                        child: Container(
                          child: Image.asset("assets/images/list.png"),
                          padding: EdgeInsets.all(5),
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(360),
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        OffersScreen(
                          "50% off",
                          "assets/images/image 90.png",
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        OffersScreen("70% off", "assets/images/image9.png"),
                        SizedBox(
                          width: 20.w,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "New Arrivals",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () async {
                              AppRoute.PushToWidget(CategoriesScreen());
                            },
                            child: Text(
                              "View All",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ProductWidget(
                                Product(
                                    name: "The Mace Jacobs",
                                    type: "TravelerTate",
                                    description:
                                        "This is a random description about the product 'The Mace Jacobs'",
                                    image:
                                        "https://i1.adis.ws/i/Marc_Jacobs/MJI_H009L01SP21_001_F8F8F8_COLOR_1-1_MAIN?w=500&qlt=100&img404=NOIMAGEMEDIUM_1-1",
                                    price: 99.5,
                                    quantity: 55),
                              ),
                              ProductWidget(
                                Product(
                                    name: "The Mace Jacobs",
                                    type: "TravelerTate",
                                    description:
                                        "This is a random description about the product 'The Mace Jacobs'",
                                    image:
                                        "https://images.stockx.com/images/The-Marc-Jacobs-The-Snapshot-Camera-Bag-Beige-Black-Pink-Metallic.jpg?fit=fill&bg=FFFFFF&w=480&h=320&fm=webp&auto=compress&dpr=2&trim=color&trimcolor=ffffff&updated_at=1646257896&q=75",
                                    price: 80,
                                    quantity: 10),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
