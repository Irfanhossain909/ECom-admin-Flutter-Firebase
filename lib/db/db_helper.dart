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
  static const String _collectionUser = 'Users';
  static const String _collectionCart = 'MyCart';
  static const String _collectionOrderSettings = 'OrderSettings';
  static const String _collectionOrder = 'Orders';
  static const String _collectionComment = 'Comments';
  static const String _collectionRatings = 'Ratings';
  static const String _documentOrderConstants = 'OrderConstants';

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

  static Stream<QuerySnapshot<Map<String, dynamic>>> getOrdersByUser (String uid) => //specefic data get from firebase
  _db.collection(_collectionOrder)
      .where('userModel.uid', isEqualTo: uid)
      .snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getAllOrderConstants() =>
      _db.collection(_collectionOrderSettings).doc(_documentOrderConstants).snapshots();


  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategoryList() =>
      _db.collection(_collectionCategory).orderBy('name').snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(_collectionProduct).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllOrders() =>
      _db.collection(_collectionOrder).snapshots();


  static Future<void> updateSingleProductField(String id, String field, dynamic value) {
    return _db.collection(_collectionProduct) //created this query methord that i can edit any field in details page,
        .doc(id)
        .update({field: value});
  }
}
