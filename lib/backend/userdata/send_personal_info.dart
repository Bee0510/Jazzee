import '../../constants.dart/constants.dart';

class SendPersonalInfo {
  //Education Section
  Future<void> sendEducation(
      String collage_name,
      String start_year,
      String end_year,
      String degree_course,
      String stream,
      String performance) async {
    try {
      await supabase.from('education').insert({
        'student_id': supabase.auth.currentUser!.id,
        'institute_name': collage_name,
        'start_year': start_year,
        'end_year': end_year,
        'degree_name': degree_course,
        'marks_per_cgpa': performance,
        'stream': stream
      });
    } catch (e) {
      print('Error sending education: $e');
    }
  }

  Future<void> editEducation(
      String collage_name,
      String start_year,
      String end_year,
      String degree_course,
      String stream,
      String performance,
      String education_id) async {
    try {
      await supabase.from('education').update({
        'student_id': supabase.auth.currentUser!.id,
        'institute_name': collage_name,
        'start_year': start_year,
        'end_year': end_year,
        'degree_name': degree_course,
        'marks_per_cgpa': performance,
        'stream': stream
      }).eq('education_id', education_id);
    } catch (e) {
      print('Error sending education: $e');
    }
  }

  //Skills Section
  Future<void> sendSkill(String skill_name, String skill_level) async {
    try {
      await supabase.from('skills').insert({
        'student_id': supabase.auth.currentUser!.id,
        'skill_name': skill_name,
        'skill_level': skill_level,
      });
    } catch (e) {
      print('Error sending skills: $e');
    }
  }

  //Work Experience Section
  Future<void> sendWorkExperience(
      String profile,
      String company,
      String is_work_from_home,
      String start_date,
      String end_date,
      String description) async {
    try {
      await supabase.from('work_experience').insert({
        'student_id': supabase.auth.currentUser!.id,
        'designation': profile,
        'organization': company,
        'job_location': is_work_from_home,
        'start_date': start_date,
        'end_date': end_date,
        'work_description': description
      });
    } catch (e) {
      print('Error sending work experience: $e');
    }
  }

  Future<void> editWorkExperience(
      String profile,
      String company,
      String is_work_from_home,
      String start_date,
      String end_date,
      String description,
      String work_exp_id) async {
    try {
      await supabase.from('work_experience').update({
        'student_id': supabase.auth.currentUser!.id,
        'designation': profile,
        'organization': company,
        'job_location': is_work_from_home,
        'start_date': start_date,
        'end_date': end_date,
        'work_description': description
      }).eq('work_exp_id', work_exp_id);
    } catch (e) {
      print('Error sending work experience: $e');
    }
  }

  //Projects Section
  Future<void> sendProject(
      String project_title,
      String current_status,
      String start_date,
      String end_date,
      String description,
      String link) async {
    try {
      await supabase.from('projects').insert({
        'student_id': supabase.auth.currentUser!.id,
        'project_title': project_title,
        'current_status': current_status,
        'start_date': start_date,
        'end_date': end_date,
        'link': link,
        'project_description': description
      });
    } catch (e) {
      print('Error sending work experience: $e');
    }
  }

  Future<void> editProject(
      String project_title,
      String current_status,
      String start_date,
      String end_date,
      String description,
      String link,
      String project_id) async {
    try {
      await supabase.from('projects').update({
        'student_id': supabase.auth.currentUser!.id,
        'project_title': project_title,
        'current_status': current_status,
        'start_date': start_date,
        'end_date': end_date,
        'project_description': description,
        'link': link
      }).eq('project_id', project_id);
    } catch (e) {
      print('Error sending work experience: $e');
    }
  }
}
