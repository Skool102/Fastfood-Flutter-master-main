import 'package:fastfood/connect/pays/pay_connect.dart';
import 'package:fastfood/main.dart';
import 'package:fastfood/models/pays/pay_model.dart';
import 'package:fastfood/utils/local_images.dart';
import 'package:fastfood/views/login/login_view.dart';
import 'package:flutter/material.dart';

import '../../utils/CommonColors.dart';
import '../../utils/constant.dart';

class MyOrders extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyOrders();
}

class _MyOrders extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return userLogin != null
        ? Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 80,
              backgroundColor: Colors.white,
              flexibleSpace: Container(
                padding:
                    const EdgeInsets.only(top: 30.0, right: 20.0, left: 10.0),
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
                    const Text(AppConstants.orders,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            body: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<List<PayModel>?>(
                future: PayConnectDB.getAllPayAdmin(),
                builder: (context, AsyncSnapshot<List<PayModel>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: const Divider(),
                              ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {},
                              child: ListTile(
                                leading: Image.asset(
                                  LocalImages.dish,
                                  width: 60.0,
                                ),
                                title: Text(
                                    snapshot.data![index].listProduct!.length <=
                                            1
                                        ? snapshot.data![index]
                                            .listProduct![index].title
                                            .toString()
                                        : '${snapshot.data![index].listProduct![index].title} vs ${snapshot.data![index].listProduct![snapshot.data![index].listProduct!.length - 1].title}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: CommonColors.primaryTextColor)),
                                subtitle: Text(
                                    '${snapshot.data![index].listProduct!.length}món,tổng:${snapshot.data![index].listProduct![index].price + snapshot.data![index].listProduct![snapshot.data![index].listProduct!.length - 1].price}  VNĐ',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: CommonColors.primaryTextColor)),
                                trailing: const Text('1 tuần trước',
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: CommonColors.primaryTextColor)),
                              ),
                            );
                          });
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
            ))
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    child: Text('Bạn chưa đăng nhập'),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView()),
                        );
                      },
                      child: const Text('Về trang đăng nhập'))
                ],
              ),
            ),
          );
  }
}
