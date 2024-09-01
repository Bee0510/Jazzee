// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:jazzee/backend/jobdata/send_message.dart';
import 'package:jazzee/constants.dart/constants.dart';
import 'package:jazzee/core/theme/base_color.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/models/chats/chat_model.dart';
import 'package:jazzee/models/chats/message_model.dart';
import 'package:jazzee/models/recruiter/recruiter_model.dart';
import 'package:jazzee/models/student/student_model.dart';
import 'package:jazzee/screens/chat_detailed_screen/widgets/interview_card.dart';
import 'package:jazzee/screens/chat_detailed_screen/widgets/schedule_interview.dart';

import '../../../notification/send_notification.dart';
import '../../videocall_screen/video_call_screen.dart';

class companyChatDetailScreen extends StatefulWidget {
  const companyChatDetailScreen(
      {Key? key, required this.student, required this.chat})
      : super(key: key);
  final Student student;
  final Chat chat;
  @override
  _chatDetailScreenState createState() => _chatDetailScreenState();
}

class _chatDetailScreenState extends State<companyChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();

  void _showScheduleDialog(BuildContext context, Message message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ScheduleInterviewDialog(
          message: message,
          student: widget.student,
        );
      },
    );
  }

  DateTime extractDateTime(String message) {
    final DateFormat formatter = DateFormat('MMM d, yyyy \'at\' h:mm a');
    final String dateTimePart = message.split('for ')[1];
    final String normalizedDateTimePart =
        dateTimePart.replaceAll(RegExp(r'\s+'), ' ');

    try {
      return formatter.parse(normalizedDateTimePart);
    } catch (e) {
      throw FormatException('Error parsing date and time: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            navigatorKey.currentState!.pop();
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/image/google_logo.png'),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.student.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.video_call, color: Colors.white),
            onPressed: () {
              navigatorKey.currentState!.push(
                  MaterialPageRoute(builder: (context) => videoCallScreen()));
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Message>>(
        stream: supabase
            .from('messages')
            .stream(primaryKey: ['id'])
            .eq('collage_id', supabase.auth.currentUser!.id)
            .order('timestamp', ascending: true)
            .map((event) => event.map(Message.fromMap).toList()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final List<Message> data = snapshot.data;
          final List<Message> messages = data
              .where((element) =>
                  element.senderId == widget.student.studentId ||
                  element.receiverId == widget.student.studentId)
              .toList();

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 80,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.beige,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.chat.firstMessage,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return messages[index].senderType == 'interview'
                            ? Align(
                                alignment: messages[index].senderId ==
                                        messages[0].collage_id
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: InterviewCard(
                                    interviewerName: widget.student.name,
                                    interviewDateTime: extractDateTime(
                                        messages[index].messageText)),
                              )
                            : Align(
                                alignment: messages[index].senderId ==
                                        messages[0].collage_id
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: messages[index].senderId !=
                                            messages[0].collage_id
                                        ? Colors.lightBlueAccent
                                            .withOpacity(0.2)
                                        : AppColors.beige,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        messages[index].messageText,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 12.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.add_circle,
                              color: AppColors.black, size: 28),
                          onPressed: () {
                            _showScheduleDialog(context, messages[0]);
                          },
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: 'Type a message',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send, color: AppColors.black),
                          onPressed: () async {
                            print(widget.student.token);
                            await sendPushMessage(widget.student.token,
                                widget.student.name, _messageController.text);
                            await SendMessage()
                                .sendMessage(
                                    widget.chat.chatId,
                                    widget.chat.studentId!,
                                    widget.chat.companyId!,
                                    _messageController.text,
                                    widget.chat.companyId!,
                                    widget.chat.studentId!)
                                .then((value) async {
                              await supabase.from('chats').update({
                                'last_message': _messageController.text,
                                'last_time': DateTime.now().toIso8601String(),
                              }).eq('id', widget.chat.chatId);
                              _messageController.clear();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
