import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper {
  DbHelper._(); // for private DbHelper class.thits no one can create this class object.
 static final _db = FirebaseFirestore.instance; //Firebase database object creating,
 static const String _collectionAdmin = 'Admins';

 static Future<bool> isAdmin(String uid) async{
   final snapshort = await _db.collection(_collectionAdmin).doc(uid).get();
   return snapshort.exists;
 }
}