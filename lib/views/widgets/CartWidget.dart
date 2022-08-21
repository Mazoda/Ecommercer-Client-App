import 'dart:developer';

import 'package:clientecommerce/AppRouter/AppRouter.dart';
import 'package:clientecommerce/data/auth_Helper.dart';
import 'package:clientecommerce/models/Product.dart';
import 'package:clientecommerce/providers/authProvider.dart';
import 'package:clientecommerce/providers/fireStoreProvider.dart';
import 'package:clientecommerce/views/Screens/FullProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatelessWidget {
  Product product;

  CartWidget(this.product);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRoute.PushToWidget(FullProduct(product));
      },
      child: Column(
        children: [
          Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {
                    Provider.of<FireStoreProvider>(context, listen: false)
                        .deleteProductFromFav(
                            product,
                            await Provider.of<AuthProvider>(context,
                                    listen: false)
                                .user!
                                .uid);
                    log(product.id);
                    log(Provider.of<AuthProvider>(context, listen: false)
                        .user!
                        .uid);
                  },
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'remove',
                ),
              ],
            ),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 130, top: 20),
                  width: 360.w,
                  height: 140.h,
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
                      child: Text(product.name,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(product.type,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 15.sp, color: Colors.grey)),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("\$"+product.price.toString(),
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontSize: 17.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ]),
                ),
                Positioned(
                    top: 10.h,
                    left: 10.w,
                    child: Container(
                      width: 110.w,
                      height: 110.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image: NetworkImage(
                              product.image,
                            ),
                            fit: BoxFit.cover),
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 40.h,
          )
        ],
      ),
    );
  }
}
