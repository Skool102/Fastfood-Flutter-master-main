import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:fastfood/connect/product/product_connect.dart';
import 'package:fastfood/widgets/bottom_navigation.dart';

import '../../../models/product.dart';
import 'package:fastfood/utils/CommonColors.dart';
import 'package:fastfood/utils/local_images.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class AddProductLayout extends StatefulWidget {
  AddProductLayout({Key? key, bool? viewLayout, Product? product})
      : _viewLayout = viewLayout,
        _product = product,
        super(key: key);
  GlobalKey<FormState>? viewKey;
  // ignore: prefer_final_fields
  Product? _product;
  final bool? _viewLayout;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() =>
      _AddProductLayout(_viewLayout, _product);
}

enum Category {
  popular(1, 'Phổ biến'),
  healthy(2, 'Healthy');

  const Category(this.id, this.name);
  final int id;
  final String name;
}

class _AddProductLayout extends State<AddProductLayout> {
  Category? selectedCategory;
  XFile? imageFile;
  Product? product;

  final _titleController = TextEditingController();
  final _addressController = TextEditingController();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  _AddProductLayout(this.viewLayout, this.product);
  bool? viewLayout;
  Category? _character = Category.popular;

  _openLybrary(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = picture;
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  // ignore: no_leading_underscores_for_local_identifiers
  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = picture;
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding: const EdgeInsets.all(5),
            alignment: Alignment.topLeft,
            title: const Padding(
              padding: EdgeInsets.all(10),
              child: Text("Make a choice!"),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: const Text("Thư viện"),
                    ),
                    onTap: () {
                      _openLybrary(context);
                    },
                  ),
                  const Divider(
                    height: 3,
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: const Text("Camera"),
                    ),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _imageView() {
    List<Widget> rows = [];
    imageFile == null
        ? rows.add(const Text("No select image"))
        : rows.add(Image.file(
            File(imageFile!.path),
            width: 400,
            height: 400,
          ));
    return rows[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          padding: const EdgeInsets.only(top: 30.0, right: 20.0, left: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  LocalImages.ic_back,
                  width: 50.0,
                  height: 50,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const Text('Thêm món',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Image.asset(
            LocalImages.logo1,
            height: 200,
          ),
          Container(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: TextFormField(
              controller: product != null
                  ? TextEditingController(text: product!.title.toString())
                  : _titleController,
              decoration: const InputDecoration(
                labelText: 'Thương hiệu',
                prefixIcon: Icon(Icons.food_bank_outlined),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: TextFormField(
              controller: product != null
                  ? TextEditingController(text: product!.name)
                  : _nameController,
              decoration: const InputDecoration(
                labelText: 'Tên món ăn',
                prefixIcon: Icon(Icons.food_bank_outlined),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text(Category.popular.name.toString()),
                leading: Radio<Category>(
                  value: Category.popular,
                  groupValue: _character,
                  onChanged: (Category? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(Category.healthy.name.toString()),
                leading: Radio<Category>(
                  value: Category.healthy,
                  groupValue: _character,
                  onChanged: (Category? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              controller: product != null
                  ? TextEditingController(text: product!.price.toString())
                  : _priceController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                hintMaxLines: 100,
                labelText: 'Giá',
                prefixIcon: Icon(Icons.attach_money),
              ),
              // inputFormatters: [
              //   NumberTextInputFormatter(
              //     integerDigits: 10,
              //     decimalDigits: 0,
              //     maxValue: '1000000000',
              //     decimalSeparator: '.',
              //     groupDigits: 3,
              //     allowNegative: false,
              //     overrideDecimalPoint: true,
              //     insertDecimalPoint: false,
              //     insertDecimalDigits: true,
              //   ),
              // ],
              keyboardType: TextInputType.number,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: TextFormField(
              controller: product != null
                  ? TextEditingController(text: product!.address)
                  : _addressController,
              decoration: const InputDecoration(
                labelText: 'Địa điểm',
                prefixIcon: Icon(Icons.food_bank_outlined),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              controller: product != null
                  ? TextEditingController(text: product!.description)
                  : _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Mô tả món ăn',
                prefixIcon: Icon(Icons.content_paste),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              minLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                _imageView(),
                ElevatedButton(
                    onPressed: () {
                      _showChoiceDialog(context);
                    },
                    child: const Text("Select Image"))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppStyle.colors[2][3])),
                onPressed: () async {
                  var image = '';
                  var title = _titleController.value.text;
                  var name = _nameController.value.text;
                  var label = _character!.name;
                  var price = _priceController.value.text;
                  var address = _addressController.value.text;
                  var description = _descriptionController.value.text;

                  final productId = (Random().nextInt(100) + 50);
                  if (imageFile != null) {
                    final bytes = File(imageFile!.path).readAsBytesSync();

                    String base64Image =
                        "data:image/png;base64,${base64Encode(bytes)}";
                    image = base64Image;
                  }
                  var money = double.tryParse(price);

                  final Product model = Product(
                      id: productId,
                      title: title,
                      name: name,
                      label: label,
                      price: money!,
                      address: address,
                      image: image,
                      description: description,
                      rating: '',
                      duration: '');

                  if (product == null) {
                    await ProductConnectDB.addProduct(model)
                        .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RBottomNavigationBar()),
                            ));
                  } else {
                    await ProductConnectDB.updateProduct(product!)
                        .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RBottomNavigationBar()),
                            ));
                  }
                },
                child: Text('Thêm món ăn',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppStyle.colors[1][0]))),
          ),
        ],
      ),
    );
  }
}
