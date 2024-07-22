
import 'package:fastfood/utils/local_images.dart';
import 'package:flutter/material.dart';
import '../../utils/constant.dart';

// ignore: use_key_in_widget_constructors
class TrackOrderView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TrackOrderView();
}

class _TrackOrderView extends State<TrackOrderView>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          backgroundColor: Colors.white, flexibleSpace: Container(
          padding: EdgeInsets.only(top: 30.0, right: 20.0, left: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },             
              ),
              const Text(AppConstants.track_order, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20.0),
            child: Image.asset(LocalImages.track_order)
        )
    );

  }
}