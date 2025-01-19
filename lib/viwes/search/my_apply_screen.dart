import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joby/viwes/search/job_detials_screen.dart';

import '../../auth_ui/signupscreen.dart';
import '../../consts/colors.dart'; // تأكد من أن هذا هو المسار الصحيح

class AppliedJobsPage extends StatelessWidget {
  const AppliedJobsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: lightGrey),

        title: const Text('الأعمال المتقدم لها',style: TextStyle(color:lightGrey),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('applications')
            .where('userId', isEqualTo: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'لم تقم بالتقديم على أي عمل حتى الآن.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          final applications = snapshot.data!.docs;

          return Stack(

            children: [
              ClipPath(
                clipper: SShapeClipper(), // تطبيق شكل S
                child: Container(
                  width: Get.width,
                  height: Get.height / 3.5,
                  color: Colors.blue,
                ),
              ),

              ListView.builder(
                itemCount: applications.length,
                itemBuilder: (context, index) {
                  final application = applications[index].data() as Map<String, dynamic>;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        application['title'] ?? 'اسم الوظيفة غير معروف',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الشركة: ${application['company'] ?? 'غير معروف'}'),
                          Text(
                            'تاريخ التقديم: ${DateTime.fromMillisecondsSinceEpoch(application['appliedAt'].millisecondsSinceEpoch).toLocal()}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,color: Colors.blue,),
                      onTap: () {
                        // عندما يتم النقر على العنصر، انتقل إلى صفحة التفاصيل
                        Get.to(() => JobDetailsPage(job: application));  // إرسال بيانات الوظيفة إلى الصفحة التالية
                      },
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
