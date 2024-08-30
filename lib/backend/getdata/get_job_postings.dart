import 'package:jazzee/models/recruiter/jobs_posting_model.dart';
import 'package:jazzee/models/student/job_applied_model.dart';
import 'package:jazzee/models/student/job_saved_model.dart';
import '../../constants.dart/constants.dart';

class GetJobPostings {
  Future<List<JobPosting>> GetAllJobs() async {
    try {
      final List<Map<String, dynamic>> _jobs =
          await supabase.from('job_postings').select();
      return _jobs.map((e) => JobPosting.fromJson(e)).toList();
    } catch (e) {
      print('Error getting locations: $e');
      return [];
    }
  }

  Future<List<JobPosting>> GetJobs(String userId) async {
    try {
      final List<Map<String, dynamic>> _jobs =
          await supabase.from('job_postings').select().eq('company_id', userId);
      return _jobs.map((e) => JobPosting.fromJson(e)).toList();
    } catch (e) {
      print('Error getting locations: $e');
      return [];
    }
  }

  Future<List<JobPosting>> GetCollegeJobs(String userId) async {
    try {
      final List<Map<String, dynamic>> _jobs = await supabase
          .from('job_postings')
          .select()
          .eq('is_specific', userId);
      return _jobs.map((e) => JobPosting.fromJson(e)).toList();
    } catch (e) {
      print('Error getting locations: $e');
      return [];
    }
  }

  Future<JobApplied> GetAppliedStatusJobs(String jobId) async {
    try {
      final List<Map<String, dynamic>> _jobs =
          await supabase.from('job_apply').select().eq('job_id', jobId);
      return JobApplied.fromJson(_jobs[0]);
    } catch (e) {
      print('Error getting locations: $e');
      return JobApplied(
        job_apply_id: '',
        jobId: '',
        jobRole: '',
        companyId: '',
        salary: '',
        jobSkills: '',
        isSpecific: '',
        acceptedByCollage: false,
        totalOpening: '',
        jobLocation: '',
        companyName: '',
        student_id: '',
        is_accepted: false,
        is_interview: false,
        is_selected: false,
        applied_on: '',
      );
    }
  }

  Future<List<JobApplied>> GetAppliedJobs(String userId) async {
    try {
      final List<Map<String, dynamic>> _jobs =
          await supabase.from('job_apply').select().eq('student_id', userId);
      return _jobs.map((e) => JobApplied.fromJson(e)).toList();
    } catch (e) {
      print('Error getting locations: $e');
      return [];
    }
  }

  Future<List<JobSaved>> GetSavedJobs(String userId) async {
    try {
      final List<Map<String, dynamic>> _jobs =
          await supabase.from('job_saved_s').select().eq('student_id', userId);
      return _jobs.map((e) => JobSaved.fromJson(e)).toList();
    } catch (e) {
      print('Error getting locations: $e');
      return [];
    }
  }
}
