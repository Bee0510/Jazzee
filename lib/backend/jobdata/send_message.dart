import '../../constants.dart/constants.dart';

class SendMessage {
  Future<void> sendMessage(
    String chat_id,
    String receiver_id,
    String sender_id,
    String message_text,
    String collage_id,
    String student_id,
  ) async {
    try {
      await supabase.from('messages').insert({
        'chat_id': chat_id,
        'receiver_id': receiver_id,
        'sender_id': sender_id,
        'message_text': message_text,
        'collage_id': collage_id,
        'student_id': student_id,
      });
    } catch (e) {
      print('Error sending location: $e');
    }
  }

  Future<void> sendFirstMessage(
    String chat_id,
    String receiver_id,
    String sender_id,
    String message_text,
    String collage_id,
    String student_id,
  ) async {
    try {
      await supabase.from('chats').insert({
        'receiver_id': receiver_id,
        'sender_id': sender_id,
        'last_message': message_text,
        'last_time': DateTime.now().toIso8601String(),
        'collage_id': collage_id,
        'student_id': student_id,
      });
      await supabase.from('messages').insert({
        'chat_id': chat_id,
        'receiver_id': receiver_id,
        'sender_id': sender_id,
        'message_text': message_text,
        'collage_id': collage_id,
        'student_id': student_id,
      });
    } catch (e) {
      print('Error sending location: $e');
    }
  }
}
