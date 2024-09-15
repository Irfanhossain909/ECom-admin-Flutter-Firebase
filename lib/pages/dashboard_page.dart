import 'package:flutter/material.dart';

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
    return const Scaffold(
      body: Center(
        child: Text('DashBoard'),
      ),
    );
  }
}
