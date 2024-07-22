import 'package:fastfood/views/menu/layouts/menu_layout.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MenuView extends StatelessWidget {
  final BuildContext? _context;

  final viewKey = GlobalKey<FormState>();
  MenuView({Key? key, BuildContext? context})
      : _context = context,
        super(key: key);

  static Page page() => MaterialPage<void>(child: MenuView());
  @override
  Widget build(BuildContext context) {
    return MenuLayout(viewKey, _context);
  }
}
