import 'package:ecom_admin/main.dart';
import 'package:ecom_admin/pages/login_page.dart';
import 'package:ecom_admin/pages/product_details.dart';
import 'package:ecom_admin/providers/auth_provider.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewProductPage extends StatefulWidget {
  static const String routeName = '/viewproduct';

  const ViewProductPage({super.key});

  @override
  State<ViewProductPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<ViewProductPage> {
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
                'Product',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.blue,
                ),
              ),
              Text(
                'View',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Consumer<ProductProvider>(
            builder: (context, provider, child) => ListView.builder(
                  itemCount: provider.productList.length,
                  itemBuilder: (context, index) {
                    final product = provider.productList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10.0,
                        child: ListTile(
                          onTap: () => Navigator.pushNamed(
                            context,
                            ProductDetailsPage.routeName,
                            arguments: product
                                .id, // takeing product id to showing specific product details in productDetailsPage.
                          ),
                          leading: CircleAvatar(
                            radius: 24.0,
                            backgroundColor: Colors.transparent,
                              child: Image.network(
                            product.imageUrl,
                          )),
                          title: Text(
                            product.productName,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 20.0),
                          ),
                          subtitle: Text(product.categoryModel.name),
                          trailing: Text(
                            'stock : ${product.stock}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    );
                  },
                )));
  }
}
