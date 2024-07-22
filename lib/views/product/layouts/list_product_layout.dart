import 'package:fastfood/connect/product/product_connect.dart';
import 'package:fastfood/models/home_model.dart';
import 'package:fastfood/models/product.dart';
import 'package:fastfood/utils/CommonColors.dart';
import 'package:fastfood/utils/local_images.dart';
import 'package:fastfood/views/product/layouts/product_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ListProductLayout extends StatefulWidget {
  ListProductLayout({Key? key, bool? viewLayout})
      : _viewLayout = viewLayout,
        super(key: key);
  GlobalKey<FormState>? viewKey;
  final bool? _viewLayout;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _ListProductLayout(_viewLayout);
}

class _ListProductLayout extends State<ListProductLayout> {
  _ListProductLayout(this.viewLayout);
  bool? viewLayout;

  bool isfavorite = true;
  @override
  Widget build(BuildContext context) {
    var products = Provider.of<HomeModel>(context).products;

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
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddProductLayout()));
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder<List<Product>?>(
          future: ProductConnectDB.getAllProduct(),
          builder: (context, AsyncSnapshot<List<Product>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddProductLayout(
                                    viewLayout: true,
                                    product: snapshot.data![index],
                                  )));
                    },
                    child: Container(
                      height: 130.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: const AssetImage(
                                LocalImages.offer_overlay,
                              ),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.white.withOpacity(0.75),
                                  BlendMode.screen)),
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: const Offset(1.0, 1.0),
                              blurRadius: 12.0,
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                products[index].image,
                                width: 100.0,
                              ),
                              const SizedBox(
                                width: 50.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data![index].title,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              CommonColors.primaryTextColor)),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(snapshot.data![index].name,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              CommonColors.primaryTextColor)),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          snapshot.data![index].price
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: CommonColors
                                                  .primaryTextColor)),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemCount: snapshot.data!.length,
                );
              }
              return const Center(
                child: Text('No notes yet'),
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
