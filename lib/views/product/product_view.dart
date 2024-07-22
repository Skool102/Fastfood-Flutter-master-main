import 'package:fastfood/views/product/layouts/list_product_layout.dart';
import 'package:fastfood/views/product/layouts/product_layout.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddProductView extends StatelessWidget {
  // ignore: unused_field
  final bool? _checkViewLayout;

  final viewKey = GlobalKey<FormState>();
  AddProductView({Key? key,bool? viewLayout})
      : _checkViewLayout = viewLayout,
        super(key: key);

  static Page page() => MaterialPage<void>(child: AddProductView());
  @override
  Widget build(BuildContext context) {
    return ListProductLayout(viewLayout: false,);
  }
}
