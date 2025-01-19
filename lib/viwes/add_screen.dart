import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joby/consts/colors.dart';
import 'package:joby/viwes/search/job_detials_screen.dart';
import 'package:joby/viwes/search/result_screen.dart';

import '../auth_ui/signupscreen.dart';

class JobSearchPage extends StatelessWidget {
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final ValueNotifier<bool?> isRemoteNotifier = ValueNotifier<bool?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: lightGrey),
        backgroundColor: Colors.blue,

        title: const Text('البحث عن الوظائف',style: TextStyle(color: lightGrey),),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: SShapeClipper(), // تطبيق شكل S
            child: Container(
              width: Get.width,
              height: Get.height / 3.5,
              color: Colors.blue,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: jobTitleController,
                    style: const TextStyle(color: Colors.white), // لون النص أبيض
                    decoration: InputDecoration(
                      labelText: 'المسمى الوظيفي',
                      labelStyle: const TextStyle(color: Colors.white), // لون التسمية أبيض
                      hintText: 'أدخل المسمى الوظيفي الذي تبحث عنه',
                      hintStyle: const TextStyle(color: Colors.white), // لون التلميح أبيض
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: countryController,
                    style: const TextStyle(color: Colors.white), // لون النص أبيض
                    decoration: InputDecoration(
                      labelText: 'الدولة',
                      labelStyle: const TextStyle(color: Colors.white), // لون التسمية أبيض
                      hintText: 'اترك الحقل فارغًا للبحث في جميع الدول',
                      hintStyle: const TextStyle(color: Colors.white), // لون التلميح أبيض
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ValueListenableBuilder<bool?>(
                    valueListenable: isRemoteNotifier,
                    builder: (context, isRemote, _) {
                      return DropdownButtonFormField<bool?>(
                        value: isRemote,
                        decoration: InputDecoration(
                          labelText: 'نوع العمل',
                          labelStyle: TextStyle(color:lightGrey),
                          hintStyle: TextStyle(color:lightGrey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:BorderSide(color: lightGrey),
                          ),
                          enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:BorderSide(color: lightGrey),
                          ),
                          focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:const BorderSide(color: lightGrey),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(value: null, child: Text('الكل',)),
                          DropdownMenuItem(value: true, child: Text('عن بعد',)),
                          DropdownMenuItem(value: false, child: Text('في الموقع')),
                        ],
                        onChanged: (value) {
                          isRemoteNotifier.value = value;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // اللون الأزرق للخلفية
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // زوايا دائرية
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ), // مساحة داخلية
                    ),
                    onPressed: () {
                      Get.to(() => JobResultsPage(
                        jobTitle: jobTitleController.text.trim(),
                        location: countryController.text.trim(),
                        isRemote: isRemoteNotifier.value,
                      ));
                    },
                    child: const Text(
                      'بحث',
                      style: TextStyle(
                        color: Colors.white, // النص باللون الأبيض
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'وظائف مشابهة',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 400, // Set a fixed height for the job list.
                    child: StreamBuilder<QuerySnapshot>(
                      stream: getJobStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text(
                              'لم يتم العثور على وظائف.',
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        }

                        final jobs = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: jobs.length,
                          itemBuilder: (context, index) {
                            final job = jobs[index].data() as Map<String, dynamic>;
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              elevation: 4,
                              child: ListTile(
                                leading: const Icon(Icons.home_work_rounded, size: 50,color: Colors.blue,),
                                title: Text(
                                  job['title'] ?? 'غير محدد',
                                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('الشركة: ${job['company'] ?? 'غير محدد'}'),
                                    Text('الموقع: ${job['location'] ?? 'غير محدد'}'),
                                    Text(
                                      'نوع العمل: ${job['isRemote'] == true ? 'عن بعد' : 'في الموقع'}',
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Get.to(() => JobDetailsPage(job: job));
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Stream<QuerySnapshot> getJobStream() {
    final jobTitle = jobTitleController.text.trim().toLowerCase(); // تحويل النص إلى حروف صغيرة للبحث المرن
    final country = countryController.text.trim();
    final isRemote = isRemoteNotifier.value;

    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection('jobs');

    // دعم البحث الجزئي بالمسمى الوظيفي
    if (jobTitle.isNotEmpty) {
      query = query.where('titleLowercase', isGreaterThanOrEqualTo: jobTitle)
          .where('titleLowercase', isLessThan: jobTitle + '\uf8ff');
    }

    // إذا كان حقل البلد غير فارغ، أضف شرط البحث الجزئي
    if (country.isNotEmpty) {
      query = query.where('location', isEqualTo: country);
    }

    // إضافة شرط نوع العمل إذا تم تحديده
    if (isRemote != null) {
      query = query.where('isRemote', isEqualTo: isRemote);
    }

    return query.snapshots();
  }
}
