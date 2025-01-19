import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joby/consts/colors.dart';
import '../../controllers/job.dart';
import 'job_detials_screen.dart';

class JobResultsPage extends StatelessWidget {
  final String? jobTitle;
  final String? location;
  final bool? isRemote;

  JobResultsPage({
    required this.jobTitle,
    required this.location,
    required this.isRemote,
  });

  final JobController jobController = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    // تنفيذ البحث عند فتح الصفحة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      jobController.searchJobs(
        jobTitle: jobTitle,
        location: location,
        isRemote: isRemote,
      );
    });

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color:lightGrey),
        backgroundColor: Colors.blue,
          title: Text('نتائج البحث',style: TextStyle(color: lightGrey),)),
      body: Obx(() {
        if (jobController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (jobController.jobs.isEmpty) {
          return const Center(child: Text('No jobs found.'));
        }
        return ListView.builder(
          itemCount: jobController.jobs.length,
          itemBuilder: (context, index) {
            final job = jobController.jobs[index];
            return ListTile(
              leading: Icon(Icons.home_work_rounded,size: 35,color: Colors.blue,),
              title: Text(job['title'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              subtitle: Text(
                '${job['company']} ',
              ),
              trailing: Text(' ${job['location']} (${job['isRemote'] ? 'Remote' : 'Onsite'})'),
              onTap: () {
                // الانتقال إلى صفحة التفاصيل مع تمرير بيانات الوظيفة
                Get.to(() => JobDetailsPage(job: job));
              },
            );
          },
        );
      }),
    );
  }
}
