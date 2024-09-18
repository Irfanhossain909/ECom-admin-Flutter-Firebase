import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_admin/models/category_model.dart';

class DbHelper {
  DbHelper._(); // for private DbHelper class.thits no one can create this class object.
 static final _db = FirebaseFirestore.instance; //Firebase database object creating,
 static const String _collectionAdmin = 'Admins';
 static const String _collectionCategory = 'Categories';

 static Future<bool> isAdmin(String uid) async{
   final snapshort = await _db.collection(_collectionAdmin).doc(uid).get();
   return snapshort.exists;
 }

 static Future<void> addCategory(CategoryModel model){
   return _db.collection(_collectionCategory).add(model.toMap());// this line create a category collection in database.

 }

 static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategoryList() =>
     _db.collection(_collectionCategory).snapshots();

}