import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joby/consts/consts.dart';
import 'package:joby/viwes/home/Views_screen.dart';
import 'package:joby/viwes/search_screen.dart';
import '../../consts/strings.dart';
import '../../controllers/news.dart';
import '../../widgets/news_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsController newsController = Get.put(NewsController());

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.to(()=>SearchScreen());
              },
              icon: const Icon(Icons.search_sharp)),
          IconButton(
              onPressed: () {
                // الإشعارات
              },
              icon: const Icon(Icons.notifications_active_sharp))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: VxSwiper.builder(
                autoPlay: true,
                itemCount:swiper.length,
                aspectRatio: 1.2,
                itemBuilder: (context, index) {
                  return Image.asset(
                    swiper[index],
                  );
                },
              ),
            ),


            Obx(() => Row( // ملاحظة تغييرات الفهرس باستخدام Obx
              mainAxisAlignment: MainAxisAlignment.center, // وضع النقاط في المنتصف
              children: List.generate( // إنشاء قائمة من النقاط
                3, // عدد النقاط
                    (index) => Container(
                  height: 5, // ارتفاع النقطة
                  width: index == newsController.currentSwiperIndex ? 20 : 5, // عرض النقطة بناءً على الفهرس الحالي
                  margin: const EdgeInsets.symmetric(horizontal: 5), // مسافة أفقية بين النقاط
                  decoration: BoxDecoration(
                    color: index == newsController.currentSwiperIndex ? appColor : fontGrey, // تغيير اللون بناءً على الفهرس
                    borderRadius: BorderRadius.circular(5), // زوايا دائرية
                  ),
                ),
              ),
            )),

            // القائمة الأفقية للتصنيفات
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:
                Obx(()=>
                    Row(
                      children: List.generate(
                        category.length,
                            (index) => Column(
                          children: [
                            TextButton(
                              onPressed: () async {
                                newsController.currentSelectedCategoryIndex.value = index;

                                // جلب الأخبار بناءً على التصنيف
                                await newsController.fetchNewsByCategory(category[index]);
                              },
                              child: Text(
                                category[index].capitalizeFirst!,
                                style: TextStyle(
                                  color: index == newsController.currentSelectedCategoryIndex.value
                                      ? appColor
                                      : darkFontGrey,
                                  fontFamily: bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              height: 5,
                              width: 50,
                              color: index == newsController.currentSelectedCategoryIndex.value
                                  ? appColor
                                  : Colors.transparent,
                            )
                          ],
                        ),
                      ),
                    ),
                )
            ),
            const SizedBox(height: 20),

            // قسم "الأكثر شيوعاً"
            Row(
              children: [
                Container(
                  height: 20,
                  width: 5,
                  color: appColor,
                ),
                const SizedBox(width: 5),
                const Text(
                  'More Popular',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // عرض الكل
                  },
                  child: TextButton(
                    onPressed: (){
                      Get.to(()=>const ViewsScreen());
                    },
                    child: const Text('View All',style: TextStyle(color: appColor, fontFamily: semibold),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),

            // عرض الأخبار بناءً على التصنيف المختار
            Expanded(
              child: Obx(() {
                if (newsController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (newsController.articles.isEmpty) {
                  return const Center(
                    child: Text("No articles found"),
                  );
                } else {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount:newsController.articles.length > 7 ? 7 : newsController.articles.length,
                    itemBuilder: (context, index) {
                      return NewsCard(index: index);
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
