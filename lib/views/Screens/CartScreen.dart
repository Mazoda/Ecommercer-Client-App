import 'package:clientecommerce/AppRouter/AppRouter.dart';
import 'package:clientecommerce/models/Category.dart';
import 'package:clientecommerce/models/Product.dart';
import 'package:clientecommerce/providers/fireStoreProvider.dart';
import 'package:clientecommerce/views/widgets/CartWidget.dart';
import 'package:clientecommerce/views/widgets/ProductWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  User? userr;

  CartScreen(this.userr);

  @override
  State<CartScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<FireStoreProvider>(context).getAllCart(widget.userr!.uid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          " Cart",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
        // automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
        child: Column(
          children: [
            Container(
                height: 700.h,
                child: Provider.of<FireStoreProvider>(context).basket.isEmpty
                    ? Lottie.asset('assets/images/empty.json')
                    : ListView.builder(
                        itemCount: Provider.of<FireStoreProvider>(context)
                            .basket
                            .length,
                        itemBuilder: (BuildContext, index) {
                          return Container(
                            margin: EdgeInsets.only(left: 20.w),
                            child: CartWidget(
                                Provider.of<FireStoreProvider>(context)
                                    .basket[index]),
                          );
                        })
                //  GridView.count(
                //     crossAxisCount: 2,
                //     childAspectRatio: (0.66),
                //     mainAxisSpacing: 10,
                //     children: List.generate(
                //         widget.products.length,
                //         (index) => ProductWidget(
                //             widget.products[index])))

                ),
          ],
        ),
      ),
    );
  }
}
