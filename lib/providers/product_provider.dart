import 'package:ecom_admin/db/db_helper.dart';
import 'package:ecom_admin/models/category_model.dart';
import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier {
  List<CategoryModel> categoryList = [];

  Future<void> addNewCategory(String name){
    final model = CategoryModel(name);
    return DbHelper.addCategory(model);
  }
  getAllCategory(){
    DbHelper.getAllCategoryList().listen((snapshot){
      categoryList = List.generate(snapshot.docs.length, (index) =>
      CategoryModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
}