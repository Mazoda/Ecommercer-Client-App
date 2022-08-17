import 'dart:developer';

import 'package:clientecommerce/models/AppUser.dart';
import 'package:clientecommerce/models/Category.dart';
import 'package:clientecommerce/models/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';

class FireStoreHelper {
  FireStoreHelper._();
  static FireStoreHelper firestore = FireStoreHelper._();
  FirebaseFirestore firestoreinstance = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");
  CollectionReference<Map<String, dynamic>> catigoriesColletionRef =
      FirebaseFirestore.instance.collection("category");
  CollectionReference<Map<String, dynamic>> productColletionRef =
      FirebaseFirestore.instance.collection("category");

  insertCollection(String colName) async {
    firestoreinstance.collection(colName).add({"hi": "asdas"});
  }

  addUserToFireBase(String userName, String email, String id) async {
    userCollection.doc(id).set({
      "email": email,
      "userID": id,
      "userName": userName,
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/e-commerce-d24b7.appspot.com/o/account.png?alt=media&token=ad4b575e-48d3-455f-9fd4-1c7496a051c2"
    });
  }

  getUserFromFireBase(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await userCollection.doc(id).get();
    Map<String, dynamic>? datamap = documentSnapshot.data();
  }

  addNewCategory(Category category) async {
    await catigoriesColletionRef.add(category.toMap());
  }

  Future<List<Category>> getAllCategories() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await catigoriesColletionRef.get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> document =
        querySnapshot.docs;
    List<Category> categories = document.map((e) {
      Category category = Category.fromMap(e.data());
      category.catId = e.id;
      return category;
    }).toList();
    return categories;
  }

  Future<AppUser> getUser(String userid) async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await userCollection.doc(userid).get();
    DocumentSnapshot<Map<String, dynamic>> document = querySnapshot;
    AppUser appUser = AppUser.fromMap(document.data()!);
 
    return appUser;
  }
  

  deleteCategory(Category category) async {
    await catigoriesColletionRef.doc(category.catId).delete();
  }

  updateCategory(Category category) async {
    await catigoriesColletionRef.doc(category.catId).update(category.toMap());
  }

  Future<Product> addNewProduct(Product product, String catId) async {
    DocumentReference<Map<String, dynamic>> document = await FirebaseFirestore
        .instance
        .collection("category")
        .doc(catId)
        .collection("products")
        .add(product.toMap());
    product.id = document.id;
    return product;
  }

  Future<Product> addToFavorites(Product product, String userId) async {
    DocumentReference<Map<String, dynamic>> document = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(userId)
        .collection("favorites")
        .add(product.toMap());
    product.id = document.id;
    return product;
  }

  Future<List<Product>> getFromFavorites(String userId) async {
    QuerySnapshot<Map<String, dynamic>> queryDocumentSnapshot =
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .collection("favorites")
            .get();
    List<Product> products = queryDocumentSnapshot.docs.map((e) {
      Product product = Product.formMap(e.data());
      product.id = e.id;
      return product;
    }).toList();
    return products;
  }

  Future<Product> addToCart(Product product, String userId) async {
    DocumentReference<Map<String, dynamic>> document = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(userId)
        .collection("basket")
        .add(product.toMap());
    product.id = document.id;
    return product;
  }

  Future<List<Product>> getAllCart(String userId) async {
    QuerySnapshot<Map<String, dynamic>> queryDocumentSnapshot =
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .collection("basket")
            .get();
    List<Product> products = queryDocumentSnapshot.docs.map((e) {
      Product product = Product.formMap(e.data());
      product.id = e.id;
      return product;
    }).toList();
    return products;
  }

  deleteProductFromCart(Product product, String userId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("basket")
        .doc(product.id)
        .delete();
  }

  deleteProductFromFav(Product product, String userId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("favorites")
        .doc(product.id)
        .delete();
  }

  Future<List<Product>> getAllProducts(String catID) async {
    QuerySnapshot<Map<String, dynamic>> queryDocumentSnapshot =
        await FirebaseFirestore.instance
            .collection("category")
            .doc(catID)
            .collection("products")
            .get();
    List<Product> products = queryDocumentSnapshot.docs.map((e) {
      Product product = Product.formMap(e.data());
      product.id = e.id;
      return product;
    }).toList();
    return products;
  }

  deleteProduct(Product product, String catID) async {
    await FirebaseFirestore.instance
        .collection("category")
        .doc(catID)
        .collection("products")
        .doc(product.id)
        .delete();
  }

  updateProduct(Product product, String catID) async {
    await FirebaseFirestore.instance
        .collection("category")
        .doc(catID)
        .collection("products")
        .doc(product.id)
        .update(product.toMap());
  }

}
