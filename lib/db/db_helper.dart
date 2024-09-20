import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_admin/models/category_model.dart';
import 'package:ecom_admin/models/product_model.dart';

class DbHelper {
  DbHelper._(); // for private DbHelper class.thits no one can create this class object.
  static final _db =
      FirebaseFirestore.instance; //Firebase database object creating,
  static const String _collectionAdmin = 'Admins';
  static const String _collectionCategory = 'Categories';
  static const String _collectionProduct = 'Products';

  static Future<bool> isAdmin(String uid) async {
    final snapshort = await _db.collection(_collectionAdmin).doc(uid).get();
    return snapshort.exists;
  }

  static Future<void> addCategory(CategoryModel model) {
    return _db.collection(_collectionCategory).add(
        model.toMap()); // this line create a category collection in database.
  }

  static Future<void> addProduct(ProductModel model) {
    final doc = _db
        .collection(_collectionProduct)
        .doc(); // create empty document in storage,
    model.id = doc.id; // set product model id to empty doc id .
    return doc.set(model.toMap()); // set the document in storage, and return.
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategoryList() =>
      _db.collection(_collectionCategory).orderBy('name').snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(_collectionProduct).snapshots();

  static Future<void> updateSingleProductField(String id, String field, dynamic value) {
    return _db.collection(_collectionProduct) //created this query methord that i can edit any field in details page,
        .doc(id)
        .update({field: value});
  }
}
