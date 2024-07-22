
import 'package:flutter/material.dart';
import 'package:fastfood/utils/local_images.dart';

import '../utils/CommonColors.dart';
import '../utils/constant.dart';

class NearbyView extends StatefulWidget {
  const NearbyView({super.key,});
  @override
  State<NearbyView> createState() => _NearbyView();
}

class _NearbyView extends State<NearbyView> {
  @override
  Widget build(BuildContext context) {
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
                    const Text(AppConstants.nearby,style: TextStyle(fontSize:25,fontWeight: FontWeight.bold,)),
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
                      height: 300.0,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                      decoration:  BoxDecoration(
                          color: Colors.white,
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
                          Container(
                            height: 180,width:MediaQuery.of(context).size.width,
                            decoration:const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(LocalImages.restro_banner,),
                                    fit: BoxFit.cover
                                ),
                                borderRadius: BorderRadius.only(topRight: Radius.circular(25.0),topLeft: Radius.circular(25.0))
                            ),

                          ),
                          SizedBox(height: 20.0,),
                          Container(
                            margin:const EdgeInsets.symmetric(horizontal: 15.0),
                            padding:const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2.0),
                            decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Text('Ăn chay',style: TextStyle(fontSize:11,color: Colors.green.shade800)),
                          ),
                          const SizedBox(height: 5.0,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Text("The Coffee House",style: TextStyle(fontSize:20.0,fontWeight: FontWeight.bold,color: CommonColors.primaryTextColor)),
                                SizedBox(width: 40.0,),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(LocalImages.ic_rating,height: 25.0,),
                                      Text(' 4.5 ',style: TextStyle(fontSize:15,color: CommonColors.primaryTextColor)),
                                    ]
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5.0,),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on_outlined,size: 15,color: Colors.grey,),
                                  Text('2.4 Km ',style: TextStyle(fontSize:12,color: CommonColors.primaryTextColor)),
                                ]
                            ),
                          ),

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