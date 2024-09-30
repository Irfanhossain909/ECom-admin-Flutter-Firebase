
import 'package:flutter/foundation.dart';

import '../db/db_helper.dart';
import '../models/order_model.dart';
import '../models/order_settings_model.dart';

class OrderProvider with ChangeNotifier {
  OrderSettingModel settingsModel = OrderSettingModel();

  List<OrderModel> userOrderList = [];
  List<OrderModel> orderList = [];


  getOrderConstants() {
    DbHelper.getAllOrderConstants().listen((snapshot) {
      settingsModel = OrderSettingModel.fromMap(snapshot.data()!);
      notifyListeners();
    });
  }

  getUserOrders(String uid) {
    DbHelper.getOrdersByUser(uid).listen((snapshot) {
      userOrderList = List.generate(snapshot.docs.length,
          (index) => OrderModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
  getAllOrders() {
    DbHelper.getAllOrders().listen((snapshot) {
      orderList = List.generate(snapshot.docs.length,
              (index) => OrderModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }


}
