import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joby/consts/colors.dart';

class JobDetailsPage extends StatelessWidget {
  final Map<String, dynamic> job;

  const JobDetailsPage({Key? key, required this.job}) : super(key: key);

  Future<void> applyForJob(BuildContext context) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    // Fetch user data from the 'users' collection
    final userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (!userSnapshot.exists) {
      Get.snackbar('خطأ', 'لم يتم العثور على ملف المستخدم.');
      return;
    }

    final userData = userSnapshot.data();
    if (userData == null) {
      Get.snackbar('خطأ', 'فشل في جلب بيانات المستخدم.');
      return;
    }

    // Prepare the application data
    final applicationData = {
      'jobId': job['id'],
      'title': job['title'],
      'company': job['company'],
      'userId': userId,
      'username': userData['username'] ?? 'غير معروف',
      'email': userData['email'] ?? 'غير معروف',
      'phone': userData['phone'] ?? 'غير مزود',
      'resume': userData['resume'] ?? 'غير مرفوع',
      'address': userData['address'] ?? 'غير مزود',
      'job': userData['job'] ?? 'غير مزود',
      'experienceLevel': userData['experience_level'] ?? 'غير مزود',
      'dob': userData['dob'] ?? 'غير مزود',
      'skills': job['skills'] ?? [],
      'certificates': userData['certificates'] ?? [],
      'appliedAt': Timestamp.now(),
      'jobDescription': job['description'] ?? 'لا يوجد وصف',
      'salary': job['salary'] ?? 'غير مزود',
      'location': job['location'] ?? 'غير مزود',
      'experienceRequired': job['experienceRequired'] ?? 0,
      'workType': job['isRemote'] == true ? 'عن بُعد' : 'في الموقع',
    };

    // Submit the application to the 'applications' collection
    try {
      await FirebaseFirestore.instance.collection('applications').add(applicationData);
      Get.snackbar('نجاح', 'تم تقديم الطلب بنجاح!',colorText:Colors.blue,backgroundColor:lightGrey,);
    } catch (e) {
      Get.snackbar('خطأ', 'فشل في تقديم الطلب. حاول مرة أخرى لاحقًا.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: lightGrey),
        title: Text(job['title'] ?? 'تفاصيل الوظيفة',style: TextStyle(
          color: lightGrey
        ),),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job['title'] ?? 'عنوان غير معروف',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.business, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'الشركة: ${job['company'] ?? 'غير معروف'}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'الموقع: ${job['location'] ?? 'غير معروف'}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.work, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'نوع العمل: ${job['isRemote'] == true ? 'عن بُعد' : 'في الموقع'}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.attach_money, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'الراتب: \$${job['salary']?.toStringAsFixed(2) ?? 'غير متوفر'}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.watch_later_rounded, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'الخبرة: ${job['experience'] ?? 0} سنوات',
                    style: const TextStyle(fontSize: 18),
                  ),

                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.bolt, size: 20),

                  const SizedBox(width: 8),
                  Expanded( // يضمن أن النص لن يتجاوز الحدود
                    child: Text(
                      'الخبرات المطلوبة: ${job['skills'] ?? 'غير معروف'}',
                      style: const TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis, // يضيف ... إذا تجاوز النص الحدود
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'وصف الوظيفة:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                job['description'] ?? 'لا يوجد وصف',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () => applyForJob(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: const Text(
            'التقديم السريع',
            style: TextStyle(fontSize: 18,color:lightGrey),
          ),
        ),
      ),
    );
  }
}
