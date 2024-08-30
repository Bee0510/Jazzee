import 'package:jazzee/models/chats/chat_model.dart';
import '../../constants.dart/constants.dart';

class GetChats {
  Future<List<Chat>> GetChat(String userId) async {
    try {
      final List<Map<String, dynamic>> _chats =
          await supabase.from('chats').select().eq('collage_id', userId);
      return _chats.map((e) => Chat.fromMap(e)).toList();
    } catch (e) {
      print('Error getting locations: $e');
      return [];
    }
  }
}
