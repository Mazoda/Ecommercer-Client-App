import 'dart:developer';
import 'dart:io';
import 'package:clientecommerce/AppRouter/AppRouter.dart';
import 'package:clientecommerce/data/auth_Helper.dart';
import 'package:clientecommerce/data/fireStore_Helper.dart';
import 'package:clientecommerce/data/storage_Helper.dart';
import 'package:clientecommerce/models/AppUser.dart';
import 'package:clientecommerce/models/Category.dart';
import 'package:clientecommerce/models/Product.dart';
import 'package:clientecommerce/providers/authProvider.dart';
import 'package:clientecommerce/views/Screens/CartScreen.dart';
import 'package:clientecommerce/views/Screens/FavoritesScreen.dart';
import 'package:clientecommerce/views/Screens/HomePage2.dart';
import 'package:clientecommerce/views/Screens/ProdcutsScreen.dart';
import 'package:clientecommerce/views/Screens/ProfileScreen.dart';
import 'package:clientecommerce/views/widgets/ProductWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class FireStoreProvider extends ChangeNotifier {
  TextEditingController categoryNameControllor = TextEditingController();
  TextEditingController producttypeControllor = TextEditingController();
  TextEditingController productNameControllor = TextEditingController();
  TextEditingController productDesControllor = TextEditingController();
  TextEditingController productPriceControllor = TextEditingController();
  TextEditingController productQuantitiyControllor = TextEditingController();
  FireStoreProvider() {
    log("message");
    print("===========================================================object");
    getAllCategories();
    userDetails();
  }
  int selectedIndex = 0;
  Widget currentWidget = HomePageTwo();

  changeSelecetedIndex(int value) {
    selectedIndex = value;
    if (selectedIndex == 0) {
      currentWidget = HomePageTwo();
    } else if (selectedIndex == 1) {
      currentWidget = CartScreen(FirebaseAuth.instance.currentUser!);
    } else if (selectedIndex == 2) {
      currentWidget = FavScreen(FirebaseAuth.instance.currentUser!);
    } else if (selectedIndex == 3) {
      currentWidget = ProfilePage(appUser!);
    }
    notifyListeners();
  }

  List<Category> categories = [];
  List<Product> favorites = [];
  List<Product> basket = [];
  List<Product>? products;
  File? selectedImage;
  AppUser? appUser;
  insertCollection(String colName) async {
    await FireStoreHelper.firestore.insertCollection(colName);
  }

  String? CatNamee(String? v) {
    if (v!.length < 3) {
      return 'Name should be more than 3';
    }
  }

  String? desc(String? v) {
    if (v!.length < 16) {
      return 'Name should be more than 16';
    }
  }

  String? type(String? v) {
    if (v!.length < 5 || v.length > 20) {
      return 'Name should between 5 and 16';
    }
  }

  String? QuanPrice(String? v) {
    if (v!.length <= 0) {
      return 'Value must be more than zero';
    } else if (v == null) {
      return "Value cant be null";
    }
  }

  // TextEditingController CatName = TextEditingController();

  selectImage() async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = File(xfile!.path);
    notifyListeners();
  }

  userDetails() async {
    User user = await AuthHelper.authHelper.getUser();
    // log(FirebaseAuth.instance.currentUser!.uid.toString() + "HIHIHI");FirebaseAuth.instance.currentUser!.uid
    appUser = await FireStoreHelper.firestore.getUser(user.uid);
    notifyListeners();
  }

  addUserToFireBase(String userName, String email, String id) async {
    await FireStoreHelper.firestore.addUserToFireBase(userName, email, id);
    notifyListeners();
  }

  getUserFromFireBase(String id) async {
    await FireStoreHelper.firestore.getUserFromFireBase(id);
    notifyListeners();
  }

  getAllCategories() async {
    categories = await FireStoreHelper.firestore.getAllCategories();
    notifyListeners();
  }

  addToCart(Product product, String userId) async {
    await FireStoreHelper.firestore.addToCart(product, userId);
    notifyListeners();
  }

  getAllCart(String userId) async {
    basket = await FireStoreHelper.firestore.getAllCart(userId);
    notifyListeners();
  }

  addToFavorites(Product product, String userId) async {
    await FireStoreHelper.firestore.addToFavorites(product, userId);
    notifyListeners();
  }

  getAllFavorties(String userId) async {
    favorites = await FireStoreHelper.firestore.getFromFavorites(userId);
    notifyListeners();
  }

  deleteProductFromFav(Product product, String userId) async {
    await FireStoreHelper.firestore.deleteProductFromFav(product, userId);
    notifyListeners();
  }

  deleteProductFromCart(Product product, String userId) async {
    await FireStoreHelper.firestore.deleteProductFromCart(product, userId);
    notifyListeners();
  }

  getAllProducts(Category category) async {
    products = await FireStoreHelper.firestore.getAllProducts(category.catId);
    AppRoute.PushToWidget(ProductsScreen(products!, category));
    notifyListeners();
  }

  Future<Widget> getProduct(Category category, int index) async {
    products = await FireStoreHelper.firestore.getAllProducts(category.catId);
    notifyListeners();
    return ProductWidget(products![index]);
  }

  getProductsCount(Category category) async {
    int count;
    products = await FireStoreHelper.firestore.getAllProducts(category.catId);
    notifyListeners();

    if (products == null) {
      count = 0;
    } else {
      count = products!.length;
    }
    return count;
  }
}
