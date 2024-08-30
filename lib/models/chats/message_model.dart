class Message {
  Message({
    required this.messageId,
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    required this.senderType,
    required this.messageText,
    required this.timestamp,
    required this.collage_id,
    required this.student_id,
    required this.sender_type,
  });

  final String messageId;
  final String chatId;
  final String senderId;
  final String receiverId;
  final String senderType;
  final String messageText;
  final DateTime timestamp;
  final String collage_id;
  final String student_id;
  final String sender_type;

  Message.fromMap(Map<String, dynamic> map)
      : messageId = map['id'] ?? '',
        chatId = map['chat_id'] ?? '',
        senderId = map['sender_id'] ?? '',
        receiverId = map['receiver_id'] ?? '',
        senderType = map['sender_type'] ?? '',
        messageText = map['message_text'] ?? '',
        timestamp = DateTime.parse(
            map['timestamp'] ?? DateTime.now().toIso8601String()),
        collage_id = map['collage_id'] ?? '',
        student_id = map['student_id'] ?? '',
        sender_type = map['sender_type'] ?? '';
}
