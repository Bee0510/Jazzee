// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jazzee/backend/jobdata/send_message.dart';
import 'package:jazzee/constants.dart/constants.dart';
import 'package:jazzee/core/theme/base_color.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/models/chats/chat_model.dart';
import 'package:jazzee/models/chats/message_model.dart';
import 'package:jazzee/models/recruiter/recruiter_model.dart';
import 'package:jazzee/screens/videocall_screen/video_call_screen.dart';

import 'widgets/interview_card.dart';

class chatDetailScreen extends StatefulWidget {
  const chatDetailScreen(
      {Key? key, required this.recruiter, required this.chat})
      : super(key: key);
  final Recruiter recruiter;
  final Chat chat;
  @override
  _chatDetailScreenState createState() => _chatDetailScreenState();
}

class _chatDetailScreenState extends State<chatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();

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
                  widget.recruiter.companyName,
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
            icon: Icon(Icons.call_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.videocam_outlined, color: Colors.white),
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
            .eq('student_id', supabase.auth.currentUser!.id)
            .order('timestamp', ascending: true)
            .map((event) => event.map(Message.fromMap).toList()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final List<Message> data = snapshot.data;
          final List<Message> messages = data
              .where((element) =>
                  element.senderId == widget.recruiter.companyId ||
                  element.receiverId == widget.recruiter.companyId)
              .toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent.withOpacity(0.2),
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
              Expanded(
                child: ListView.builder(
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
                                interviewerName: widget.recruiter.companyName,
                                interviewDateTime: extractDateTime(
                                    messages[index].messageText)),
                          )
                        : Align(
                            alignment: messages[index].senderId ==
                                    messages[index].student_id
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: messages[index].senderId !=
                                        messages[index].student_id
                                    ? Colors.lightBlueAccent.withOpacity(0.2)
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
                                  // SizedBox(height: 4),
                                  // Text(
                                  //   messages[index].timestamp.toString(),
                                  //   style: TextStyle(
                                  //     color: Colors.grey,
                                  //     fontSize: 10,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.add_circle,
                          color: AppColors.black, size: 28),
                      onPressed: () {},
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
                        print(widget.chat.chatId);
                        print(widget.chat.companyId);
                        print(widget.chat.studentId);
                        await SendMessage()
                            .sendMessage(
                                widget.chat.chatId,
                                widget.chat.companyId!,
                                widget.chat.studentId!,
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
            ],
          );
        },
      ),
    );
  }
}
