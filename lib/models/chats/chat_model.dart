// class Chat {
//   final int chatId;
//   final int? companyId;
//   final int? collageId;
//   final int? studentId;
//   final String initiatedBy;
//   final bool isActive;
//   final String sender_id;
//   final String receiver_id;
//   final String last_message;
//   final String last_time;

//   Chat({
//     required this.chatId,
//     this.companyId,
//     this.collageId,
//     this.studentId,
//     required this.initiatedBy,
//     required this.isActive,
//     required this.sender_id,
//     required this.receiver_id,
//     required this.last_message,
//     required this.last_time,
//   });

//   factory Chat.fromJson(Map<String, dynamic> json) {
//     return Chat(
//       chatId: json['chat_id'] ?? 0,
//       companyId: json['company_id'],
//       collageId: json['collage_id'],
//       studentId: json['student_id'],
//       initiatedBy: json['initiated_by'] ?? '',
//       isActive: json['is_active'] ?? true,
//       sender_id: json['sender_id'] ?? '',
//       receiver_id: json['receiver_id'] ?? '',
//       last_message: json['last_message'] ?? '',
//       last_time: json['last_time'] ?? '',
//     );
//   }
// }
class Chat {
  Chat({
    required this.chatId,
    this.companyId,
    this.collageId,
    this.studentId,
    required this.initiatedBy,
    required this.isActive,
    required this.senderId,
    required this.receiverId,
    required this.lastMessage,
    required this.lastTime,
    required this.firstMessage,
  });

  final String chatId;
  final String? companyId;
  final String? collageId;
  final String? studentId;
  final String initiatedBy;
  final bool isActive;
  final String senderId;
  final String receiverId;
  final String lastMessage;
  final String lastTime;
  final String firstMessage;

  Chat.fromMap(Map<String, dynamic> map)
      : chatId = map['id'] ?? '',
        companyId = map['company_id'],
        collageId = map['collage_id'],
        studentId = map['student_id'],
        initiatedBy = map['initiated_by'] ?? '',
        isActive = map['is_active'] ?? true,
        senderId = map['sender_id'] ?? '',
        receiverId = map['receiver_id'] ?? '',
        lastMessage = map['last_message'] ?? '',
        lastTime = map['last_time'] ?? '',
        firstMessage = map['first_message'] ?? '';
}
