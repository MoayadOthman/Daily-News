import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class JobController extends GetxController {
  var jobs = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  Future<void> searchJobs({
    String? jobTitle,
    String? location,
    bool? isRemote,
  }) async {
    isLoading.value = true;
    try {
      Query query = FirebaseFirestore.instance.collection('jobs');
      if (jobTitle != null && jobTitle.isNotEmpty) {
        query = query.where('title', isGreaterThanOrEqualTo: jobTitle)
            .where('title', isLessThanOrEqualTo: '$jobTitle\uf8ff');
      }
      if (location != null) {
        query = query.where('location', isEqualTo: location);
      }
      if (isRemote != null) {
        query = query.where('isRemote', isEqualTo: isRemote);
      }
      QuerySnapshot snapshot = await query.get();
      jobs.value = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error searching jobs: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
