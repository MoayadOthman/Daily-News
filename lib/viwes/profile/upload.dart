import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:get/get.dart';

class UploadFileScreen extends StatefulWidget {
  final String title;
  final String fieldName;
  final String userId;

  const UploadFileScreen({
    required this.title,
    required this.fieldName,
    required this.userId,
  });

  @override
  _UploadFileScreenState createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  File? selectedFile;
  bool isUploading = false;

  // Future<void> _pickFile() async {
  //   // فتح نافذة لاختيار الملفات
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom, // تحديد نوع الملفات
  //     allowedExtensions: ['jpg', 'png', 'pdf'], // السماح فقط بالصور وملفات PDF
  //     allowMultiple: false, // للسماح بملف واحد فقط
  //   );
  //
  //   if (result != null && result.files.single.path != null) {
  //     setState(() {
  //       selectedFile = File(result.files.single.path!);
  //     });
  //   }
  // }

  // Future<void> _uploadFile() async {
  //   if (selectedFile == null) return;
  //
  //   setState(() {
  //     isUploading = true;
  //   });
  //
  //   try {
  //     String fileName = path.basename(selectedFile!.path);
  //     String storagePath = 'uploads/${widget.userId}/${widget.fieldName}/$fileName';
  //
  //     // رفع الملف إلى Firebase Storage
  //     final Reference storageRef = FirebaseStorage.instance.ref(storagePath);
  //     await storageRef.putFile(selectedFile!);
  //
  //     // الحصول على رابط التنزيل
  //     String downloadUrl = await storageRef.getDownloadURL();
  //
  //     // تحديث البيانات في Firestore
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(widget.userId)
  //         .update({
  //       widget.fieldName: FieldValue.arrayUnion([downloadUrl]),
  //     });
  //
  //     Get.snackbar(
  //       "نجاح",
  //       "تم رفع الملف بنجاح!",
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.green,
  //       colorText: Colors.white,
  //     );
  //   } catch (e) {
  //     Get.snackbar(
  //       "خطأ",
  //       "حدث خطأ أثناء رفع الملف: $e",
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   } finally {
  //     setState(() {
  //       isUploading = false;
  //       selectedFile = null; // إعادة ضبط الاختيار بعد الرفع
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedFile != null)
              selectedFile!.path.endsWith('.pdf')
                  ? Icon(Icons.picture_as_pdf, size: 100, color: Colors.red)
                  : Image.file(
                selectedFile!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            else
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey[300],
                child: Center(
                  child: Text("لم يتم اختيار ملف بعد."),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: (){},
              // isUploading ? null : _pickFile,
              icon: Icon(Icons.file_upload),
              label: Text("اختر ملف"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: (){},
              //isUploading ? null : _uploadFile,
              icon: Icon(Icons.cloud_upload),
              label: Text(isUploading ? "جاري الرفع..." : "رفع الملف"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
