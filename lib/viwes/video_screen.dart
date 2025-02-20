
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joby/consts/consts.dart';
import 'package:joby/viwes/news_details_screen.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        title: const Text('Video Articles',style: TextStyle(color: appColor,fontSize: 30,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.sort)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.refresh)),

        ],
      ),
      body: Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView.builder(
        itemCount: 3,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Get.to(()=>const NewsDetailsScreen(article: {},));
              },
              child: Card(
                    color:Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: Colors.red,
                      width: context.width,
                      height: 150,
                      child:Stack(
                        children: [
                          Transform.scale(
                            scale: 2,
                            child:
                            const Icon(Icons.play_circle_fill_outlined)
                            ,
                          ),
                        ],
                      ),

                    ),
                    10.heightBox,
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('asdasdsaasdsd'.allWordsCapitilize(),style: const TextStyle(),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.timer_outlined,color:appColor,),
                                    5.widthBox,
                                    Text('20 April'.allWordsCapitilize(),style: const TextStyle(color:appColor),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border,)),
                                    const Text('215',style: TextStyle(),),
                                  ],
                                ),

                              ],
                            ),
                          ],
                        ))
                  ],

                ),

              ),

              );
          },),),
    );
  }
}
