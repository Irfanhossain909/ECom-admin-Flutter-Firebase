
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../customwidgets/header_view.dart';
import '../models/order_model.dart';
import '../providers/order_provider.dart';
import '../utils/constants.dart';

class OrderDetailsPage extends StatefulWidget {
  static const String routeName = '/orderdetails';

  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late OrderModel orderModel;

  @override
  void didChangeDependencies() {
    final id = ModalRoute
        .of(context)!
        .settings
        .arguments as String;
    orderModel = context.read<OrderProvider>().getOrderById(id);
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
              'Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          const HeaderView(title: 'Products'),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for(final cart in orderModel.cartList)
                  ListTile(
                    trailing: Text('$currency${cart.price}'),
                    title: Text(cart.ProductName),
                    subtitle: Text('Quantity: ${cart.quantity}'),
                    leading: CircleAvatar(
                      child: CachedNetworkImage(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: cart.image,
                        placeholder: (context, url) =>
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                        const Center(
                          child: Icon(
                            Icons.error,
                          ),
                        ),
                        fadeInDuration: const Duration(milliseconds: 1000),
                        fadeInCurve: Curves.bounceInOut,
                      ),
                    ),
                  )
              ],
            ),
          ),
          const HeaderView(title: 'Order Summery'),
          Card(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Discount',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${orderModel.orderSettingModel.discount}%',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Delivery Charge ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '$currency${orderModel.orderSettingModel.delevaryCharge}',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'VAT',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${orderModel.orderSettingModel.vat}%',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Divider(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Grand Total  : $currency${orderModel.grandTotal}',
                        style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const HeaderView(title: 'Customer Information'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(orderModel.userModel.email),
                 Text(orderModel.delevaryAddress.streetLine),
                 Text(orderModel.delevaryAddress.zipCode),
                 Text(orderModel.delevaryAddress.city),
               ],
              ),
            ),
          ),
          const HeaderView(title: 'Order Status'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(orderModel.orderStatus),
            ),
          )



        ],
      ),
    );
  }
}
