import 'dart:developer';
import 'package:clientecommerce/AppRouter/AppRouter.dart';
import 'package:clientecommerce/models/Product.dart';
import 'package:clientecommerce/providers/fireStoreProvider.dart';
import 'package:clientecommerce/views/Screens/FullProduct.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FavProduct extends StatelessWidget {
  Product product;

  FavProduct(this.product);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRoute.PushToWidget(FullProduct(product));
      },
      child: Container(
        height: 280.h,
        width: 200.w,
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
                width: 200.w,
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 2, color: Colors.black),
                  image: DecorationImage(
                      image: NetworkImage(product.image), fit: BoxFit.cover),
                )),
            SizedBox(
              height: 4.h,
            ),
            Text(product.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                )),
            Text(product.type,
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.poppins(fontSize: 15.sp, color: Colors.grey)),
            Text("\$" + product.price.toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                )),
          ],
        ),
      ),
    );
  }
}
