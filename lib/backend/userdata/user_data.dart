import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/college/college_model.dart';
import '../../models/recruiter/recruiter_model.dart';
import '../../models/student/student_model.dart';

class UserService {
  final supabase = Supabase.instance.client;

  Future<Map<String, dynamic>> fetchUserById(String userId, String role) async {
    try {
      dynamic data;
      if (role == 'students') {
        data = await supabase
            .from('students')
            .select()
            .eq('student_id', userId)
            .limit(1);
        if (data == null) throw Exception('Student not found');
        print('data: $data');
        return {'user': Student.fromJson(data[0], null), 'role': 'students'};
      } else if (role == 'recruiter') {
        data = await supabase
            .from('recruiter')
            .select()
            .eq('company_id', userId)
            .limit(1);
        if (data == null) throw Exception('Recruiter not found');
        return {'user': Recruiter.fromJson(data[0], null), 'role': 'recruiter'};
      } else if (role == 'collage') {
        print('userId: $userId');
        data = await supabase
            .from('collage')
            .select()
            .eq('collage_id', userId)
            .limit(1);
        print('data: $data');
        if (data == null) throw Exception('Collage not found');
        return {'user': Collage.fromJson(data[0], null), 'role': 'collage'};
      } else {
        throw Exception('Invalid role');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      rethrow;
    }
  }
}
