import '../../constants.dart/constants.dart';
import '../../models/recruiter/jobs_posting_model.dart';
import '../../models/student/job_filter_model.dart';

class FilterJobs {
  Future<List<JobPosting>> fetchFilteredJobs(
      JobFilters filters, String? searchQuery) async {
    var query = supabase.from('job_postings').select();

    if (filters.jobTypes != null && filters.jobTypes!.isNotEmpty) {
      for (var jobtype in filters.jobTypes!) {
        query = query.ilike('job_type', '%$jobtype%');
      }
    }

    if (filters.salary != null && filters.salary!.isNotEmpty) {
      query = query.gte('salary', filters.salary!);
    }

    if (filters.skills != null && filters.skills!.isNotEmpty) {
      for (var skill in filters.skills!) {
        query = query.ilike('job_requirement', '%$skill%');
      }
    }
    if (searchQuery!.isNotEmpty) {
      query = query.or(
          'job_role.ilike.%$searchQuery%,company_name.ilike.%$searchQuery%,job_requirement.ilike.%$searchQuery%,job_location.ilike.%$searchQuery%');
    }
    final response = await query;

    return response.map((e) => JobPosting.fromJson(e)).toList();
  }

  Future<List<JobPosting>> fetchFilteredCollageJobs(
      JobFilters filters, String? searchQuery, String collage_id) async {
    var query =
        supabase.from('job_postings').select().eq('is_specific', collage_id);

    if (filters.jobTypes != null && filters.jobTypes!.isNotEmpty) {
      for (var jobtype in filters.jobTypes!) {
        query = query.ilike('job_type', '%$jobtype%');
      }
    }

    if (filters.salary != null && filters.salary!.isNotEmpty) {
      query = query.gte('salary', filters.salary!);
    }

    if (filters.skills != null && filters.skills!.isNotEmpty) {
      for (var skill in filters.skills!) {
        query = query.ilike('job_requirement', '%$skill%');
      }
    }
    if (searchQuery!.isNotEmpty) {
      query = query.or(
          'job_role.ilike.%$searchQuery%,company_name.ilike.%$searchQuery%,job_requirement.ilike.%$searchQuery%,job_location.ilike.%$searchQuery%');
    }
    final response = await query;

    return response.map((e) => JobPosting.fromJson(e)).toList();
  }
}
