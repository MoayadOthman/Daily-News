import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:joby/consts/colors.dart';

class EditSkillsScreen extends StatefulWidget {
  final String userId;
  final List<String> skills;

  const EditSkillsScreen({required this.userId, required this.skills});

  @override
  _EditSkillsScreenState createState() => _EditSkillsScreenState();
}

class _EditSkillsScreenState extends State<EditSkillsScreen> {
  final TextEditingController _skillController = TextEditingController();
  late List<String> skills;

  @override
  void initState() {
    super.initState();
    skills = List.from(widget.skills); // نسخ القائمة لتجنب تعديلها مباشرة
  }

  Future<void> _saveSkills() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .update({'skills': skills});

      Get.snackbar(
        "نجاح",
        "تم تحديث المهارات بنجاح!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.blue,
      );
      Navigator.pop(context); // العودة إلى الصفحة السابقة
    } catch (e) {
      Get.snackbar(
        "خطأ",
        "حدث خطأ أثناء تحديث المهارات: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _addSkill() {
    if (_skillController.text.trim().isNotEmpty) {
      setState(() {
        skills.add(_skillController.text.trim());
        _skillController.clear();
      });
    }
  }

  void _removeSkill(int index) {
    setState(() {
      skills.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: lightGrey),
        title: Text("تعديل المهارات",style: TextStyle(color: lightGrey),),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveSkills,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _skillController,
              decoration: InputDecoration(
                labelText: "أضف مهارة جديدة",
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addSkill,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: skills.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(skills[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeSkill(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
