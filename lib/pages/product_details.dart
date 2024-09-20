import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_admin/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../utils/widgets_functions.dart';

class ProductDetailsPage extends StatefulWidget {
  static const String routeName = '/productdetails';

  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late ProductModel product; //decleard a veriable to recive product id.

  @override
  void didChangeDependencies() {
    final id = ModalRoute.of(context)!.settings.arguments
        as String; //recived id to exicute this line,now i have specofic product id,
    product = context.watch<ProductProvider>().getProductFromListById(
        id); //use context.watch to update widget automaticlly.alwys use context.read,
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            width: double.infinity,
            height: 250.0,
            fit: BoxFit.cover,
            imageUrl: product.imageUrl,
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
          //----------------------------------------------------
          //--------------Product Name-------------------------
          ListTile(
            title: Text(product.productName),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                    context: context,
                    title: 'Update Title',
                    onSave: (value) {
                      context
                          .read<ProductProvider>()
                          .updateSingleProductField(product.id!, 'name', value);
                      showMsg(context, 'Updated');
                    });
              },
              icon: const Icon(
                Icons.edit,
              ),
            ),
          ),
          //----------------------------------------------------------
          ListTile(
            title: Text('price: ${product.price}TK'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                  context: context,
                  textInputType: TextInputType.number,
                  positiveButtonText: 'Update',
                  title: 'Update Price',
                  onSave: (value) {
                    context.read<ProductProvider>().updateSingleProductField(
                        product.id!, 'price', num.parse(value));
                    showMsg(context, 'Price Updated');
                  },
                );
              },
              icon: const Icon(
                Icons.edit,
              ),
            ),
          ),
          ListTile(
            title: Text('discount: ${product.discountPercent}%'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                    textInputType: TextInputType.number,
                    context: context,
                    title: 'Discount',
                    onSave: (value) {
                      context.read<ProductProvider>().updateSingleProductField(
                          product.id!, 'discountPercent', int.parse(value));
                    });
              },
              icon: const Icon(
                Icons.edit,
              ),
            ),
          ),
          ListTile(
            title:
                Text('after discount: ${product.priceAfterDiscount}TK'),
          ),
          ListTile(
            title: Text('Stock: ${product.stock}'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                    context: context,
                    title: 'Update Stock',
                    onSave: (value) {
                      context.read<ProductProvider>().updateSingleProductField(
                          product.id!, 'stock', num.parse(value));
                      showMsg(context, 'Stock Updated');
                    });
              },
              icon: const Icon(
                Icons.edit,
              ),
            ),
          ),
          SwitchListTile(
            value: product.available,
            title: const Text('Stock Availability'),
            onChanged: (value) {
              context
                  .read<ProductProvider>()
                  .updateSingleProductField(product.id!, 'available', value);
              showMsg(context, 'Status Updated');
            },
          ),
        ],
      ),
    );
  }
}
