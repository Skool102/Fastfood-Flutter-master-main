
import 'package:flutter/material.dart';
import 'package:fastfood/utils/local_images.dart';
import 'package:provider/provider.dart';

import '../models/home_model.dart';
import '../utils/CommonColors.dart';
import '../utils/constant.dart';

class MostPopularView extends StatefulWidget {
  const MostPopularView({super.key,});
  @override
  State<MostPopularView> createState() => _MostPopularView();
}

class _MostPopularView extends State<MostPopularView> {
  @override
  Widget build(BuildContext context) {
    var products = Provider.of<HomeModel>(context).products;
    return Scaffold(
      body:CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 80.0,
          floating: true,
            pinned: false,automaticallyImplyLeading: false,
            flexibleSpace: Container(
              padding: EdgeInsets.only(top:30.0,right: 20.0,left: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Image.asset(LocalImages.ic_back,width: 50.0,height: 50,fit: BoxFit.fitWidth,),
                  ),
                  const Text(AppConstants.popular,style: TextStyle(fontSize:25,fontWeight: FontWeight.bold,)),
                ],
              ),
            ),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  InkWell(
                    child:Container(
                      width: MediaQuery.of(context).size.width-100,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color:Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                            )
                          ]
                      ),
                      child: Row(
                        children: [
                          Image.asset(LocalImages.ic_search,width: 30.0,),
                          const SizedBox(width: 10.0,),
                          const Text(AppConstants.search,style: TextStyle(fontSize: 18,color: CommonColors.primaryTextColor),)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  InkWell(
                    child: Image.asset(LocalImages.ic_filter,height: 58.0,),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  height: 280.0,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                  padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 30.0),
                  decoration:  BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage(LocalImages.offer_overlay,),
                          fit: BoxFit.cover,colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.75),BlendMode.screen
                      )
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          offset: Offset(1.0, 1.0),
                          blurRadius: 12.0,
                        )
                      ]
                  ),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Image.asset(products[index].image,height: 100.0),),
                      SizedBox(height: 20.0,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 2.0),
                        decoration: BoxDecoration(
                            color: Colors.amber.shade100,
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Text(products[index].label,style: TextStyle(fontSize:12,color: Colors.amber.shade800)),
                      ),
                      SizedBox(height: 8.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(products[index].name,style: TextStyle(fontSize:25.0,fontWeight: FontWeight.bold,color: CommonColors.primaryTextColor)),
                              SizedBox(height: 8.0,),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(products[index].duration,style: TextStyle(fontSize:16,color: CommonColors.primaryTextColor)),
                                    SizedBox(width: 10.0,),Icon(Icons.circle,size: 8,color: Colors.grey,), SizedBox(width: 10.0,),
                                    Image.asset(LocalImages.ic_rating,height: 20.0,),
                                    Text(products[index].rating,style: TextStyle(fontSize:16,color: CommonColors.primaryTextColor)),
                                  ]
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: (){},
                            child: Container(
                              padding:EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
                              decoration:BoxDecoration(
                                color: CommonColors.primaryTextColor,
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Text('Thêm',style: TextStyle(fontSize:16,fontWeight:FontWeight.bold,color: Colors.white)),
                            )
                          )
                        ],
                      )

                    ],
                  ),
                );
              },
              childCount: 10,
            )
          )
        ],
      )

    );
  }

}