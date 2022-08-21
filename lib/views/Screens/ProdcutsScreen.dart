import 'package:clientecommerce/AppRouter/AppRouter.dart';
import 'package:clientecommerce/models/Category.dart';
import 'package:clientecommerce/models/Product.dart';
import 'package:clientecommerce/providers/fireStoreProvider.dart';
import 'package:clientecommerce/views/widgets/ProductWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  List<Product> products;
  Category category;
  ProductsScreen(this.products, this.category);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.category.name + " Products",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
        child: Column(
          children: [
            Container(
                height: 650.h,
                child: Provider.of<FireStoreProvider>(context).products == null
                    ? Lottie.asset('assets/images/empty.json')
                    : GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: (0.66),
                        mainAxisSpacing: 10,
                        children: List.generate(
                            widget.products.length,
                            (index) => ProductWidget(
                                widget.products[index])))),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
