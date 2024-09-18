import 'dart:io';
import 'package:ecom_admin/models/category_model.dart';
import 'package:ecom_admin/models/product_model.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:ecom_admin/utils/widgets_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewProductPage extends StatefulWidget {
  static const String routeName = '/newpeoduct';

  const NewProductPage({super.key});

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _discountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CategoryModel? categoryModel;
  String? localImagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Product'),
        actions: [
          IconButton(
            onPressed: _saveProduct,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    child: localImagePath == null
                        ? const Icon(
                            Icons.person,
                            size: 100.0,
                          )
                        : Image.file(
                            File(localImagePath!),
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          _getImage(ImageSource.camera);
                        },
                        icon: const Icon(Icons.camera),
                        label: const Text('Capture'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          _getImage(ImageSource.gallery);
                        },
                        icon: const Icon(Icons.photo),
                        label: const Text('gallery'),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8.0,
                ),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Product Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product name in empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8.0,
                ),
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Product Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Description in empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8.0,
                ),
                child: TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    hintText: 'Product Price',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Price in empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8.0,
                ),
                child: TextFormField(
                  controller: _stockController,
                  decoration: const InputDecoration(
                    hintText: 'Stock',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Stock in empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8.0,
                ),
                child: TextFormField(
                  controller: _discountController,
                  decoration: const InputDecoration(
                    hintText: 'Discount % (Optional)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                child: Consumer<ProductProvider>(
                  builder: (context, provider, child) =>
                      DropdownButtonFormField<CategoryModel>(
                    hint: const Text('Select Category'),
                    isExpanded: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    items: provider.categoryList
                        .map((model) => DropdownMenuItem<CategoryModel>(
                            value: model, child: Text(model.name)))
                        .toList(),
                    onChanged: (value) {
                      categoryModel = value;
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void _getImage(ImageSource source) async {
    final xFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: 60,
    );
    if (xFile != null) {
      localImagePath = xFile.path;
      print('image clicked');
    }
  }

  void _saveProduct() async {
    if (localImagePath == null) {
      showMsg(context, 'Image not selected');
      return;
    }
    if (_formKey.currentState!.validate()) {// valodate all feild
      EasyLoading.show(status: 'Please Wait...');
      try{
        final url = await context.read<ProductProvider>().uploadImageRetSrorage(
            localImagePath!); //after upload image in storage and get url,
        final product = ProductModel(
          productName: _nameController.text,
          categoryModel: categoryModel!,
          price: num.parse(_priceController.text),// using num.parse to convert num type to String,
          stock: num.parse(_stockController.text),
          description: _descriptionController.text,
          imageUrl: url,
        );
        await context.read<ProductProvider>().addNewProduct(product);
        showMsg(context, 'Product Uploaded');
        _resetFields();
        EasyLoading.dismiss();
      }catch(error){
        EasyLoading.dismiss();
        showMsg(context, error.toString());
      }
    }
  }

  void _resetFields() {// to reset all the fields after uploaded the product.
    setState(() {
      _nameController.clear();
      _priceController.clear();
      _descriptionController.clear();
      _stockController.clear();
      _discountController.clear();
      categoryModel = null;
      localImagePath = null;

    });
  }
}
