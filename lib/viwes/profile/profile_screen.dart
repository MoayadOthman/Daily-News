import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joby/consts/colors.dart';
import 'package:joby/viwes/profile/upload.dart';
import '../../auth_ui/signupscreen.dart';
import 'edit_profile_screen.dart';
import 'edit_skils_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

   ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: lightGrey),
        title: const Text("الملف الشخصي",style: TextStyle(color: lightGrey),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("لا توجد بيانات متاحة."));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

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

          SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const CircleAvatar(
          backgroundColor:lightGrey,
          radius: 60,
            child: Icon(Icons.person,size: 55,),
          ),
          // القسم الأول: بطاقة المعلومات الشخصية
          const SectionHeader(title: "المعلومات الشخصية"),
          buildInfoCard(
          context,
          "المعلومات الشخصية",
          [
          "الاسم: ${userData['username'] ?? "غير معروف"}",
          "البريد الإلكتروني: ${userData['email'] ?? "غير معروف"}",
          "الهاتف: ${userData['phone'] ?? "غير مضاف"}",
          "العنوان: ${userData['address'] ?? "غير مضاف"}",
          "العمل: ${userData['job'] ?? "غير مضاف"}",
          "مستوى الخبرة: ${userData['experience_level'] ?? "غير مضاف"}",
          "المواليد: ${userData['dob'] ?? "غير مضاف"}",
          ],
          () => Get.to(() => EditPersonalInfoScreen(userData: userData)),
          ),
          const SizedBox(height: 20),

          // القسم الثاني: المهارات والخبرات
          const SectionHeader(title: "المهارات والخبرات"),
          buildInfoCard(
          context,
          "المهارات والخبرات",
          [
          "عدد المهارات: ${userData['skills'] != null ? userData['skills'].length : 0}",
          ...?userData['skills']?.map((skill) => "- $skill").toList(),
          ],
          () => Get.to(() => EditSkillsScreen(
          userId: userId,
          skills: List<String>.from(userData['skills'] ?? []),
          )),
          ),
          const SizedBox(height: 20),

          // القسم الثالث: التدريبات والشهادات
          const SectionHeader(title: "التدريبات والشهادات"),
          buildListSection(
          context,
          "الشهادات",
          userData['certificates'] as List<dynamic>? ?? [],
          () => Get.to(() => UploadFileScreen(
          title: "إضافة الشهادات",
          fieldName: "certificates",
          userId: userId,
          )),
          ),
          const SizedBox(height: 20),

          // القسم الرابع: السيرة الذاتية
          const SectionHeader(title: "السيرة الذاتية"),
          buildResumeSection(context, userData),
          ],
          ),
          )
          ],
          );
        },
      ),
    );
  }

  // إنشاء بطاقة المعلومات
  Widget buildInfoCard(BuildContext context, String title, List<String> info, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: info.map((item) => Text(item)).toList(),
        ),
        trailing: const Icon(Icons.edit),
        onTap: onTap,
      ),
    );
  }

  // إنشاء قسم عرض قائمة
  Widget buildListSection(
      BuildContext context, String title, List<dynamic> items, VoidCallback onAdd) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: onAdd,
            ),
          ),
          items.isNotEmpty
              ? Column(
            children: items
                .map((item) => ListTile(
              leading: const Icon(Icons.file_present),
              title: Text(item),
            ))
                .toList(),
          )
              : const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("لا توجد بيانات مضافة."),
          ),
        ],
      ),
    );
  }

  // إنشاء قسم السيرة الذاتية
  Widget buildResumeSection(BuildContext context, Map<String, dynamic> userData) {
    String? resumeUrl = userData['resume'];
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: const Icon(Icons.picture_as_pdf),
        title: const Text("السيرة الذاتية"),
        subtitle: Text(resumeUrl != null ? "عرض السيرة الذاتية" : "لا توجد سيرة ذاتية"),
        trailing: IconButton(
          icon: const Icon(Icons.upload_file),
          onPressed: () => Get.to(() => UploadFileScreen(
              title: "رفع السيرة الذاتية", fieldName: "resume", userId: userId)),
        ),
        onTap: resumeUrl != null
            ? () {
          // عرض ملف PDF
          Get.to(() => PDFViewerScreen(pdfUrl: resumeUrl));
        }
            : null,
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }
}
class PDFViewerScreen extends StatelessWidget {
  final String pdfUrl;

  PDFViewerScreen({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    // استبدل هذا بكود عرض ملف PDF
    return Scaffold(
      appBar: AppBar(title: const Text("عرض السيرة الذاتية")),
      body: const Center(child: Text("عرض السيرة الذاتية هنا.")),
    );
  }
}