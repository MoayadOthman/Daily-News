import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joby/consts/colors.dart';
import 'home/category_details_screen.dart'; // صفحة لعرض أخبار التصنيف

class CategoriesPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Technology', 'icon': Icons.computer, 'color': Colors.blue},
    {'name': 'Sports', 'icon': Icons.sports_soccer, 'color': Colors.green},
    {'name': 'Cooking', 'icon': Icons.restaurant_menu, 'color': Colors.orange},
    {'name': 'Travel', 'icon': Icons.flight, 'color': Colors.purple},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Categories',style: TextStyle(color: appColor,fontSize: 30,fontWeight: FontWeight.bold),),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // عدد الأعمدة في الشبكة
          crossAxisSpacing: 10, // المسافة بين الأعمدة
          mainAxisSpacing: 10, // المسافة بين الصفوف
          childAspectRatio: 1.5, // نسبة عرض وارتفاع كل عنصر في الشبكة
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // الانتقال إلى صفحة أخبار التصنيف مع تمرير اسم التصنيف
              Get.to(() => CategoryDetailsScreen(categoryName: categories[index]['name']));
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: categories[index]['color'],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      categories[index]['icon'],
                      size: 50,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      categories[index]['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
