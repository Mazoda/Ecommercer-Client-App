import 'dart:developer';

import 'package:clientecommerce/models/Category.dart';
import 'package:clientecommerce/providers/fireStoreProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CatWidget extends StatelessWidget {
  Category category;
  int index;
  CatWidget(this.category, this.index, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, top: 20.h),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Provider.of<FireStoreProvider>(context, listen: false)
                  .getAllProducts(category);
            },
            child: Container(
              width: 340.w,
              height: 150.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 2, color: Colors.black),
                // boxShadow: const [
                //   BoxShadow(
                //       spreadRadius: 3,
                //       blurRadius: 5,
                //       color: Color.fromARGB(255, 197, 196, 196))
                // ],
                image: DecorationImage(
                    image: NetworkImage(category.imageUrl),
                    fit: BoxFit.cover),
              ),
              child: Align(
                alignment: index % 2 == 0
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Column(
                  children: [
                    Container(
                      margin: index % 2 == 0
                          ? EdgeInsets.only(top: 50.h, left: 20.w)
                          : EdgeInsets.only(top: 50.h, right: 20.w),
                      child: Text(category.name,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 0, 242),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }
}
