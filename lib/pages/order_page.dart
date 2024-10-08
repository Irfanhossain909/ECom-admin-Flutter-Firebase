import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_admin/main.dart';
import 'package:ecom_admin/pages/login_page.dart';
import 'package:ecom_admin/pages/order_details.dart';
import 'package:ecom_admin/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';
import '../utils/constants.dart';

class OrderPage extends StatefulWidget {
  static const String routeName = '/order';

  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<OrderPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'Order',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.blue,
              ),
            ),
            Text(
              'List',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) => provider.orderList.isEmpty
            ? const Center(
                child: Text('No Order'),
              )
            : ListView.builder(
                itemCount: provider.orderList.length,
                itemBuilder: (context, index) {
                  final order = provider.orderList[index];
                  return ListTile(
                    onTap: () => Navigator.pushNamed(
                      context,
                      OrderDetailsPage.routeName,
                      arguments: order.orderId,
                    ),
                    title: Text(order.orderId!),
                    subtitle: Text(order.orderStatus),
                    trailing: Text('$currency${order.grandTotal}'),
                    leading: CircleAvatar(
                      child: CachedNetworkImage(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: order.cartList.first.image,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(
                            Icons.error,
                          ),
                        ),
                        fadeInDuration: const Duration(milliseconds: 1000),
                        fadeInCurve: Curves.bounceInOut,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
