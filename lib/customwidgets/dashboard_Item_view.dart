import 'package:ecom_admin/models/dashboard_model.dart';
import 'package:flutter/material.dart';

class DashboardItemView extends StatelessWidget {
  const DashboardItemView({super.key, required this.model});

  final DashboardItemModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, model.routeName),
      child: Card(
        shadowColor: Colors.green,
        surfaceTintColor: Colors.black,
        elevation: 14,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                model.iconData,
                color: Colors.green,
                size: 70.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                model.title,
                style: const TextStyle(
                    fontSize: 22.0, fontWeight: FontWeight.bold,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
