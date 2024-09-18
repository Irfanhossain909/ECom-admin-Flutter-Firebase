import 'package:ecom_admin/pages/category_page.dart';
import 'package:ecom_admin/pages/new_product_page.dart';
import 'package:ecom_admin/pages/order_page.dart';
import 'package:ecom_admin/pages/view_product.dart';
import 'package:flutter/material.dart';

class DashboardItemModel {
  final String title;
  final IconData iconData;
  final String routeName;

  const DashboardItemModel({
    required this.title,
    required this.iconData,
    required this.routeName,
  });
}

const dashboardItems = [
  DashboardItemModel(title: 'New Product', iconData: Icons.card_giftcard, routeName: NewProductPage.routeName),
  DashboardItemModel(title: 'Category', iconData: Icons.category, routeName: CategoryPage.routeName),
  DashboardItemModel(title: 'Product List', iconData: Icons.list, routeName: ViewProductPage.routeName),
  DashboardItemModel(title: 'Order List', iconData: Icons.work, routeName: OrderPage.routeName),
];