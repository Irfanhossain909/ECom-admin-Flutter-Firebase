

import 'dart:io';

import 'package:ecom_admin/db/db_helper.dart';
import 'package:ecom_admin/models/category_model.dart';
import 'package:ecom_admin/models/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier {
  List<CategoryModel> categoryList = [];

  Future<void> addNewCategory(String name){
    final model = CategoryModel(name);
    return DbHelper.addCategory(model);
  }

  Future<void>addNewProduct(ProductModel model){
    return DbHelper.addProduct(model);
  }

  getAllCategory(){
    DbHelper.getAllCategoryList().listen((snapshot){
      categoryList = List.generate(snapshot.docs.length, (index) =>
      CategoryModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  Future<String> uploadImageRetSrorage(String localPath) async{
    final imageName = 'Image_${DateTime.now().millisecondsSinceEpoch}';// create image name on storage.
    final imageRef = FirebaseStorage.instance.ref().child('Images/$imageName');//create Image folder in storage and named image file,
    final task = imageRef.putFile(File(localPath));
    final snapshot = await task.whenComplete((){}); //whenComplete((){}) methord call after file uploaded.
    return snapshot.ref.getDownloadURL();
  }
}