import 'package:clientecommerce/models/AppUser.dart';
import 'package:clientecommerce/providers/fireStoreProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  AppUser user;
  ProfilePage(this.user);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 40.h, left: 15.w),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 130, top: 20),
                    width: 360.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 4,
                              blurRadius: 4,
                              color: Colors.grey.shade300,
                              offset: Offset.fromDirection(20)),
                        ]),
                    child: Column(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.user.userName!,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            )),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.user.email!,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 15.sp, color: Colors.grey)),
                      )
                    ]),
                  ),
                  Positioned(
                      top: 15.h,
                      left: 30.w,
                      child: Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              image: NetworkImage(
                                widget.user.imageUrl!,
                              ),
                              fit: BoxFit.cover),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                // margin: EdgeInsets.only(top: 30.h, left: 10.w),
                height: 600.h,
                width: 380.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 1, color: Colors.grey.shade500)),
                child: Column(children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  MyWidget("Personal Details", Icons.person),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                      onTap: () {
                        Provider.of<FireStoreProvider>(context, listen: false)
                            .changeSelecetedIndex(1);
                      },
                      child: MyWidget("My Cart", Icons.card_travel)),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                      onTap: () {
                        Provider.of<FireStoreProvider>(context, listen: false)
                            .changeSelecetedIndex(2);
                      },
                      child: MyWidget("My Favourites", Icons.favorite_sharp)),
                  SizedBox(
                    height: 20.h,
                  ),
                  MyWidget("Shipping Address", Icons.delivery_dining_sharp),
                  SizedBox(
                    height: 20.h,
                  ),
                  MyWidget("My Card", Icons.credit_card),
                  SizedBox(
                    height: 20.h,
                  ),
                  MyWidget("Settings", Icons.settings),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  IconData icon;
  String title;
  MyWidget(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200,
            ),
            height: 50.h,
            width: 50.w,
            child: Icon(icon, color: Colors.black),
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded),
          SizedBox(
            width: 20.w,
          )
        ],
      ),
    );
  }
}
