
import 'package:ecom_admin/db/db_helper.dart';
import 'package:ecom_admin/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
  List<UserModel> userList = [];


  getAllUsers() {
    DbHelper.getAllUsers().listen((snapshot) {
      userList = List.generate(snapshot.docs.length,
              (index) => UserModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }


  Future<bool> loginAdmin(String email, String password) async{
    final credenchial = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return DbHelper.isAdmin(credenchial.user!.uid);// take uid for matching login uid!!!

  }
  Future<void> logout() => _auth.signOut();
}