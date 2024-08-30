import 'package:jazzee/models/student/job_applied_model.dart';
import 'package:jazzee/models/student/student_model.dart';
import '../../constants.dart/constants.dart';

class GetApplicants {
  Future<List<Student>> GetApplicant(String jobId) async {
    try {
      final List<Map<String, dynamic>> _locations = await supabase
          .from('job_apply')
          .select()
          .eq('job_id', jobId)
          .eq('recrute_status', false);

      final List<JobApplied> jobapplied =
          _locations.map((e) => JobApplied.fromJson(e)).toList();

      final List<String> studentIds =
          jobapplied.map((e) => e.student_id).toList();

      // Fetch the student details for each student ID
      final List<Student> students = [];
      for (String studentId in studentIds) {
        final studentData = await supabase
            .from('students')
            .select()
            .eq('student_id', studentId)
            .single();

        if (studentData != null) {
          students.add(Student.fromJson(studentData, null));
        }
      }

      return students;
    } catch (e) {
      print('Error getting applicants: $e');
      return [];
    }
  }
}
