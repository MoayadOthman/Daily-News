import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AddJobPage extends StatelessWidget {
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isRemoteNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة وظيفة')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(
                  controller: jobTitleController,
                  label: 'المسمى الوظيفي',
                  validatorMessage: 'يرجى إدخال المسمى الوظيفي',
                ),
                _buildTextField(
                  controller: companyNameController,
                  label: 'اسم الشركة',
                  validatorMessage: 'يرجى إدخال اسم الشركة',
                ),
                _buildTextField(
                  controller: locationController,
                  label: 'مكان الوظيفة',
                  validatorMessage: 'يرجى إدخال مكان الوظيفة',
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: isRemoteNotifier,
                  builder: (context, isRemote, _) {
                    return Row(
                      children: [
                        const Text('وظيفة عن بُعد:'),
                        Checkbox(
                          value: isRemote,
                          onChanged: (value) {
                            isRemoteNotifier.value = value ?? false;
                          },
                        ),
                      ],
                    );
                  },
                ),
                _buildTextField(
                  controller: salaryController,
                  label: 'الراتب المتوقع',
                  keyboardType: TextInputType.name,
                  validatorMessage: 'يرجى إدخال الراتب المتوقع',
                ),
                _buildTextField(
                  controller: experienceController,
                  label: 'عدد سنوات الخبرة',
                  keyboardType: TextInputType.number,
                  validatorMessage: 'يرجى إدخال عدد سنوات الخبرة',
                ),
                _buildTextField(
                  controller: skillsController,
                  keyboardType: TextInputType.multiline, // تحديد نوع لوحة المفاتيح كمتعدد الأسطر
                  maxLines: 10,
                  label: 'المهارات المطلوبة (افصل بينها بفواصل)',
                  validatorMessage: 'يرجى إدخال المهارات المطلوبة',
                ),
                _buildTextField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline, // تحديد نوع لوحة المفاتيح كمتعدد الأسطر
                  maxLines: 10,
                  label: 'وصف الوظيفة',
                  validatorMessage: 'يرجى إدخال وصف الوظيفة',
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await addJob(
                        jobTitle: jobTitleController.text,
                        companyName: companyNameController.text,
                        location: locationController.text,
                        isRemote: isRemoteNotifier.value,
                        salary: double.tryParse(salaryController.text) ?? 0.0,
                        experience: int.tryParse(experienceController.text) ?? 0,
                        skills: skillsController.text.split(',').map((e) => e.trim()).toList(),
                        description: descriptionController.text,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم إضافة الوظيفة بنجاح!')),
                      );
                      formKey.currentState!.reset();
                    }
                  },
                  child: const Text('إضافة وظيفة'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addJob({
    required String jobTitle,
    required String companyName,
    required String location,
    required bool isRemote,
    required double salary,
    required int experience,
    required List<String> skills,
    required String description,
  }) async {
    final job = {
      'title': jobTitle,
      'company': companyName,
      'location': location,
      'isRemote': isRemote,
      'salary': salary,
      'experience': experience,
      'skills': skills,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance.collection('jobs').add(job);
    } catch (e) {
      print('Error adding job: $e');
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String validatorMessage,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatorMessage;
          }
          return null;
        },
      ),
    );
  }
}
