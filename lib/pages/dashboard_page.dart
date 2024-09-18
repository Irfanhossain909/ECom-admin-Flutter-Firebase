import 'package:ecom_admin/customwidgets/dashboard_Item_view.dart';
import 'package:ecom_admin/main.dart';
import 'package:ecom_admin/models/dashboard_model.dart';
import 'package:ecom_admin/pages/login_page.dart';
import 'package:ecom_admin/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = '/dashB';

  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<DashboardPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<FirebaseAuthProvider>().logout().then((_) {
                Navigator.pushReplacementNamed(context, LoginPage.routeName);
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 5,
          ),
          itemCount: dashboardItems.length,
          itemBuilder: (context, index) {
            final item = dashboardItems[index];
            return DashboardItemView(model: item);
          },
        ),
      ),
    );
  }
}
