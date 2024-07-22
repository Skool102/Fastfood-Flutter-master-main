import 'package:fastfood/models/pays/pay_model.dart';
import 'package:fastfood/utils/local_images.dart';
import 'package:fastfood/views/payment_mode.dart';
import 'package:flutter/material.dart';
import '../../utils/CommonColors.dart';
import '../../utils/constant.dart';

// ignore: must_be_immutable
class AddressView extends StatefulWidget {
  AddressView({Key? key, PayModel? pay})
      : pays = pay,
        super(key: key);

  PayModel? pays;
  @override
  State<StatefulWidget> createState() => _AddressView(pays);
}

class _AddressView extends State<AddressView> {
  _AddressView(this.pays);

  PayModel? pays;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var address = "";
    return Scaffold(
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
                const Text(AppConstants.address,
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
            child: ListView(
              children: [
                const Text('Giao tới',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: CommonColors.primaryTextColor)),
                InkWell(
                  onTap: () {
                    address = '1111 Sư Vạn Hạnh, Quận 10, TPHCM';
                  },
                  child: ListTile(
                    tileColor: Colors.grey.shade100,
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      child: const Icon(
                        Icons.location_on_outlined,
                      ),
                    ),
                    title: const Text('Nhà',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: CommonColors.primaryTextColor)),
                    subtitle: Text('1111 Sư Vạn Hạnh, Quận 10, TPHCM',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade700)),
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                ),
                InkWell(
                  onTap: () {
                    address = '808 Sư Vạn Hạnh, Quận 10, TPHCM';
                  },
                  child: ListTile(
                    tileColor: Colors.grey.shade100,
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      child: const Icon(
                        Icons.location_on_outlined,
                      ),
                    ),
                    title: const Text('Công ty',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: CommonColors.primaryTextColor)),
                    subtitle: Text('808 Sư Vạn Hạnh, Quận 10, TPHCM',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade700)),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      pays!.address = '1111 Sư Vạn Hạnh, Quận 10, TPHCM';;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentView(
                                  pay: pays,
                                )),
                      );
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width - 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: CommonColors.primaryColor.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(15)),
                      child: const Text('Sử dụng địa chỉ này',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                )
              ],
            )));
  }
}
