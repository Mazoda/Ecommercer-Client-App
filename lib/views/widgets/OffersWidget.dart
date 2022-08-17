import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OffersScreen extends StatelessWidget {
  String title;
  String imagea;
  OffersScreen(this.title, this.imagea);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30.w, top: 10.h),
      width: 330.w,
      height: 160.h,
      decoration: BoxDecoration(
          color: Color.fromRGBO(167, 167, 167, 0),
          borderRadius: BorderRadius.circular(40),
          image: DecorationImage(image: AssetImage(imagea), fit: BoxFit.cover)),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(title,
                style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                )),
          ),
          SizedBox(
            height: 5.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("On every thing today",
                style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  color: Color.fromARGB(255, 0, 0, 0),
                )),
          ),
          SizedBox(
            height: 5.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("with code: FSCKASFO",
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 141, 141, 141),
                )),
          ),
          SizedBox(
            height: 5.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 50.w,
              height: 30.h,
              child: Container(
                padding: EdgeInsets.only(left: 15.w, top: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black,
                ),
                child: Text("Get",
                    style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
