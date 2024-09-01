import '../../constants.dart/constants.dart';

class SendPosts {
  Future<void> sendMPost(
    String post_by,
    String post_des,
    String image,
    String post_by_name,
    String collage_name,
  ) async {
    try {
      await supabase.from('post').insert({
        'post_by': post_by,
        'post_des': post_des,
        'image': image,
        'post_by_name': post_by_name,
        'collage_name': collage_name,
        'created_at': DateTime.now().toString(),
      });
    } catch (e) {
      print('Error sending location: $e');
    }
  }
}
