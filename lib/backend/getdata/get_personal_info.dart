import 'package:jazzee/models/college/college_model.dart';
import 'package:jazzee/models/recruiter/recruiter_model.dart';
import 'package:jazzee/models/student/education_model.dart';
import 'package:jazzee/models/student/projects_model.dart';
import 'package:jazzee/models/student/skills_model.dart';
import 'package:jazzee/models/student/student_model.dart';
import 'package:jazzee/models/student/work_experience.dart';

import '../../constants.dart/constants.dart';

class GetPersonalInfo {
  Future<Student> GetUserStudent(String student_id) async {
    try {
      final List<Map<String, dynamic>> _student =
          await supabase.from('students').select().eq('student_id', student_id);
      return Student.fromJson(_student.first, null);
    } catch (e) {
      print('Error getting skills: $e');
      return Student(
          studentId: '',
          name: '',
          phoneNo: '',
          email: '',
          collegeId: '',
          collageName: '',
          image: '',
          verified: false,
          dateOfBirth: '',
          collage: null,
          roleType: '',
          placedOnCampus: false,
          roll_no: '',
          token: '');
    }
  }

  Future<List<Education>> GetUserEducation() async {
    try {
      final List<Map<String, dynamic>> _education = await supabase
          .from('education')
          .select()
          .eq('student_id', supabase.auth.currentUser!.id);
      print('skills: $_education');
      return _education.map((e) => Education.fromJson(e)).toList();
    } catch (e) {
      print('Error getting skills: $e');
      return [];
    }
  }

  Future<List<Skill>> GetUserSkills() async {
    try {
      final List<Map<String, dynamic>> _skills = await supabase
          .from('skills')
          .select()
          .eq('student_id', supabase.auth.currentUser!.id);
      return _skills.map((e) => Skill.fromJson(e)).toList();
    } catch (e) {
      print('Error getting skills: $e');
      return [];
    }
  }

  Future<List<WorkExperience>> GetUserWorkExperience() async {
    try {
      final List<Map<String, dynamic>> _experience = await supabase
          .from('work_experience')
          .select()
          .eq('student_id', supabase.auth.currentUser!.id);
      return _experience.map((e) => WorkExperience.fromJson(e)).toList();
    } catch (e) {
      print('Error getting work exp: $e');
      return [];
    }
  }

  Future<List<Projects>> GetUserProjects() async {
    try {
      final List<Map<String, dynamic>> _projects = await supabase
          .from('projects')
          .select()
          .eq('student_id', supabase.auth.currentUser!.id);
      return _projects.map((e) => Projects.fromJson(e)).toList();
    } catch (e) {
      print('Error getting projects: $e');
      return [];
    }
  }

  Future<Collage> GetCollageInfo() async {
    try {
      final List<Map<String, dynamic>> _collageInfo = await supabase
          .from('collage')
          .select()
          .eq('collage_id', supabase.auth.currentUser!.id);
      print('collage: $_collageInfo');
      return Collage.fromJson(_collageInfo.first, null);
    } catch (e) {
      print('Error getting projects: $e');
      return Collage(
          collageId: '',
          collageMail: '',
          collageName: '',
          collageNo: '',
          collageCode: '',
          studentEnrolled: 0,
          coordinatorName: '',
          roleType: '',
          websiteLink: '',
          token: '');
    }
  }

  Future<List<Student>> GetCollageStudent() async {
    try {
      final List<Map<String, dynamic>> _collageInfo = await supabase
          .from('students')
          .select()
          .eq('college_id', supabase.auth.currentUser!.id);
      return _collageInfo.map((e) => Student.fromJson(e, null)).toList();
    } catch (e) {
      print('Error getting collage student: $e');
      return [];
    }
  }

  //Company
  Future<Recruiter> GetCompanyInfo(String companyId) async {
    try {
      final List<Map<String, dynamic>> _company =
          await supabase.from('recruiter').select().eq('company_id', companyId);
      return Recruiter.fromJson(_company.first, null);
    } catch (e) {
      print('Error getting company student: $e');
      return Recruiter(
          companyId: '',
          companyName: '',
          roleType: 'recruiter',
          gst: '',
          link: '',
          token: '');
    }
  }
}
