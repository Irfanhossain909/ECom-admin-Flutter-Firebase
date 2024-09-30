import 'package:ecom_admin/main.dart';
import 'package:ecom_admin/pages/login_page.dart';
import 'package:ecom_admin/providers/auth_provider.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:ecom_admin/utils/widgets_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  static const String routeName = '/category';

  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<CategoryPage> {
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
                'Cate',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.blue,
                ),
              ),
              Text(
                'gory',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showSingleTextInputDialog(
                context: context,
                title: 'New Category',
                onSave: (value) async {
                  EasyLoading.show(status: 'Pleace Wait....');
                  await context.read<ProductProvider>().addNewCategory(value);
                  EasyLoading.dismiss();
                  showMsg(context, 'Category Saved');
                });
          },
          child: const Icon(Icons.add),
        ),
        body: Consumer<ProductProvider>(
          builder: (context, provider, child) => provider.categoryList.isEmpty
              ? const Center(
                  child: Text('No Category Found'),
                )
              : ListView.builder(
                  itemCount: provider.categoryList.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Card(child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(provider.categoryList[index].name,style: const TextStyle(fontSize: 18.0),),
                    )),
                  ),
                ),
        ));
  }
}
