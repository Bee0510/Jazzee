import '../../constants.dart/constants.dart';

class SendJobApplyInfo {
  Future<void> sendJobApply(
    String company_id,
    String job_id,
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
    String student_id,
    String resume_link,
    bool is_accepted,
    bool is_interview,
    bool is_selected,
    String applied_on,
  ) async {
    try {
      await supabase.from('job_apply').insert({
        'company_id': company_id,
        'job_id': job_id,
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
        'student_id': student_id,
        'resume_link': resume_link,
        'is_accepted': is_accepted,
        'is_interviewed': is_interview,
        'is_selected': is_selected,
        'applied_on': applied_on,
      });
    } catch (e) {
      print('Error sending location: $e');
    }
  }
}
