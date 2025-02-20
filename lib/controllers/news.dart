import 'package:get/get.dart'; // استيراد مكتبة GetX لإدارة الحالة والتنقل بين الصفحات.
import '../consts/strings.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class NewsController extends GetxController {
  final String apiKey = "a250e3b7e47140e5b608b33b73138a68"; // مفتاح API الخاص بخدمة NewsAPI (استبدله بمفتاحك الخاص)
  final String baseUrl = "https://newsapi.org/v2/top-headlines"; // عنوان URL الأساسي للحصول على الأخبار



  final _currentSwiperIndex = 0.obs;
  get currentSwiperIndex => _currentSwiperIndex.value;
  set currentSwiperIndex(value) => _currentSwiperIndex.value = value;


  var articles = <dynamic>[].obs;
  var isLoading = true.obs;

  var likedArticles = <int, bool>{}.obs;

  var searchQuery = ''.obs;

  var country = 'us'.obs;
  RxInt currentSelectedCategoryIndex = 0.obs;





  void onInit() {
    super.onInit();

    refreshNews();
  }

  changeSwiperIndex(int value){
    currentSwiperIndex=value;
  }



//الدالة الأولى هي الأساس لجلب الأخبار، بينما الدالة الثانية تُضيف طبقة لإدارة الحالة وتسهيل التفاعل مع واجهة المستخدم.
  void refreshNews() async {
    // تغيير حالة التحميل إلى true، أي أن البيانات قيد التحميل.
    isLoading.value = true;
    try {
      // جلب الأخبار من الخدمة بناءً على الدولة المحددة.
      final news = await fetchNews(country.value);
      // تخزين المقالات التي تم جلبها في قائمة المقالات.
      articles.value = news;
    } catch (e) {
      print("Error fetching news: $e");
      // طباعة رسالة خطأ إذا حدثت مشكلة أثناء جلب الأخبار.
    } finally {
      isLoading.value = false;
      // تغيير حالة التحميل إلى false عند الانتهاء.
    }
  }

  // دالة للبحث عن المقالات.
  void searchArticles() async {
    // التحقق من أن النص المدخل للبحث غير فارغ.
    if (searchQuery.value.isNotEmpty) {

      try {
        // جلب الأخبار بناءً على النص المدخل للبحث.
        final news = await fetchNewsByQuery(searchQuery.value);
        // تحديث قائمة المقالات بالنتائج التي تم العثور عليها.
        articles.value = news;
      } catch (e) {
        print("Error searching articles: $e");
        // طباعة رسالة خطأ إذا حدثت مشكلة أثناء البحث.
      }
    }
  }


  void toggleLike(int index) {
    // تغيير حالة الإعجاب للمقالة بناءً على الحالة الحالية. إذا لم تكن موجودة، يتم تعيينها كـ false.

    likedArticles[index] = !(likedArticles[index] ?? false);
  }

  // تعريف دالة لجلب الأخبار حسب الدولة
  Future<List<dynamic>> fetchNews(String country) async {
    try {
      // تشكيل رابط الطلب مع الدولة المحددة
      final url = Uri.parse("$baseUrl?country=$country&apiKey=$apiKey");

      // إرسال طلب GET إلى الرابط
      final response = await http.get(url);

      // التحقق من حالة الاستجابة (200 تعني نجاح الطلب)
      if (response.statusCode == 200) {
        // فك ترميز النص القادم من الاستجابة إلى صيغة JSON وتحويله إلى Map
        final Map<String, dynamic> data = json.decode(response.body);

        // إرجاع قائمة المقالات الموجودة في البيانات (articles)
        return data['articles'];
      } else {
        // إذا كانت حالة الاستجابة ليست 200، يتم إطلاق استثناء
        throw Exception("Failed to fetch news");
      }
    } catch (e) {
      // طباعة رسالة الخطأ إذا حدث استثناء أثناء العملية
      print("Error: $e");
      // إعادة إطلاق استثناء مع رسالة خطأ
      throw Exception("Error fetching news");
    }
  }


  //تعريف دالة للبحث عن الاخبار حسب اي شي مدخل
  Future<List<dynamic>> fetchNewsByQuery(String query) async {
    try{
      //تشكيل رابط بين العنوان الاساسي و المفتاح و الاستعلام
      final url = Uri.parse("https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey");
      //ارسال طلب لرابط للحصول على بيانات
      final response = await http.get(url);
      // التحقق من حالة الاستجابة (200 تعني نجاح الطلب)

      if (response.statusCode == 200) {
        // فك ترميز النص القادم من الاستجابة إلى صيغة JSON وتحويله إلى Map

        final Map<String, dynamic> data = json.decode(response.body);
        return data['articles']; // قائمة المقالات
      } else {
        throw Exception("Failed to fetch news by query");
      }
    }
    catch(e){
      print("Error: $e");
      throw Exception("Error fetching news by query");
    }
  }




  Future<void> fetchNewsByCategory(String category) async {

    isLoading.value = true;
    try {
      final url = Uri.parse("$baseUrl?category=$category&apiKey=$apiKey");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        articles.value = data['articles'];
      } else {
        articles.clear();
        throw Exception("Failed to load news");
      }
    } catch (e) {
      articles.clear();
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }


}

