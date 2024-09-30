
import 'package:ecom_admin/firebase_options.dart';
import 'package:ecom_admin/providers/auth_provider.dart';
import 'package:ecom_admin/providers/order_provider.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'pages/category_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/launcher_page.dart';
import 'pages/login_page.dart';
import 'pages/new_product_page.dart';
import 'pages/order_page.dart';
import 'pages/product_details.dart';
import 'pages/user_page.dart';
import 'pages/view_product.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FirebaseAuthProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),//use EasyLoading to show loading screen.
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName : (context) => const LauncherPage(),
        LoginPage.routeName : (context) => const LoginPage(),
        DashboardPage.routeName : (context) => const DashboardPage(),
        NewProductPage.routeName : (context) => const NewProductPage(),
        CategoryPage.routeName : (context) => const CategoryPage(),
        ViewProductPage.routeName : (context) => const ViewProductPage(),
        OrderPage.routeName : (context) => const OrderPage(),
        ProductDetailsPage.routeName : (context) => const ProductDetailsPage(),
        UserListPage.routeName : (context) => const UserListPage(),
      },
    );
  }
}