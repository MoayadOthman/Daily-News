import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class EditPersonalInfoScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  EditPersonalInfoScreen({required this.userData});

  @override
  _EditPersonalInfoScreenState createState() => _EditPersonalInfoScreenState();
}

class _EditPersonalInfoScreenState extends State<EditPersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _jobController;
  late TextEditingController _experienceController;
  late TextEditingController _dobController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.userData['username']);
    _emailController = TextEditingController(text: widget.userData['email']);
    _phoneController = TextEditingController(text: widget.userData['phone']);
    _addressController = TextEditingController(text: widget.userData['address']);
    _jobController = TextEditingController(text: widget.userData['job']);
    _experienceController = TextEditingController(text: widget.userData['experience_level']);
    _dobController = TextEditingController(text: widget.userData['dob']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تعديل المعلومات الشخصية"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField("الاسم", _usernameController),
              buildTextField("البريد الإلكتروني", _emailController),
              buildTextField("الهاتف", _phoneController),
              buildTextField("العنوان", _addressController),
              buildTextField("العمل", _jobController),
              buildTextField("مستوى الخبرة", _experienceController),
              buildTextField("المواليد", _dobController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _updatePersonalInfo();
                  }
                },
                child: Text("حفظ التعديلات"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "الرجاء إدخال $label";
          }
          return null;
        },
      ),
    );
  }

  Future<void> _updatePersonalInfo() async {
    try {
      EasyLoading.show(status: "جاري التحديث...");
      String userId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'username': _usernameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
        'job': _jobController.text,
        'experience_level': _experienceController.text,
        'dob': _dobController.text,
      });

      EasyLoading.dismiss();
      Get.snackbar(
        "تم التحديث",
        "تم تحديث المعلومات الشخصية بنجاح.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.back();
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        "خطأ",
        "حدث خطأ أثناء تحديث البيانات.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
