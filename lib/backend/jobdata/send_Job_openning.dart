import '../../constants.dart/constants.dart';

class SendJobPostingInfo {
  Future<void> sendJobOpenings(
    String company_id,
    String job_role,
    String job_type,
    String salary,
    String is_specific,
    String job_descriptions,
    String job_requirements,
    String total_opening,
    String job_loactions,
    String company_name,
    String apply_till,
  ) async {
    try {
      await supabase.from('job_postings').insert({
        'company_id': company_id,
        'job_role': job_role,
        'job_type': job_type,
        'salary': salary,
        'is_specific': is_specific,
        'job_description': job_descriptions,
        'job_requirement': job_requirements,
        'total_opening': total_opening,
        'job_location': job_loactions,
        'company_name': company_name,
        'apply_till': apply_till ?? '',
      });
    } catch (e) {
      print('Error sending location: $e');
    }
  }
}
