import 'package:jazzee/models/post/post_model.dart';
import '../../constants.dart/constants.dart';

class GetPosts {
  Future<List<Post>> GetPost() async {
    try {
      final List<Map<String, dynamic>> _locations =
          await supabase.from('post').select();
      return _locations.map((e) => Post.fromMap(e)).toList();
    } catch (e) {
      print('Error getting locations: $e');
      return [];
    }
  }
}
