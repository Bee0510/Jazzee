// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jazzee/components/skeletal_text.dart';
import 'package:jazzee/components/text_field.dart';
import 'package:jazzee/constants.dart/constants.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/models/chats/chat_model.dart';
import 'package:jazzee/models/recruiter/recruiter_model.dart';
import 'package:jazzee/screens/videocall_screen/video_call_screen.dart';
import 'package:jazzee/screens/videocall_screen/workshop.dart';
import '../../../../core/theme/base_color.dart';
import '../chat_detailed_screen/chat_detailed_screen.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, dynamic>> chatList = [
    {
      'name': 'Rozanne Barrientes',
      'message': 'A wonderful serenity has taken...',
      'avatar': 'assets/image/google_logo.png',
      'unread': false,
    },
    {
      'name': 'Anaya Sanji',
      'message': 'What about Paypal?',
      'avatar': 'assets/image/google_logo.png',
      'unread': false,
    },
    {
      'name': 'Elizabeth Olsen',
      'message': 'We should move forward to talk with...',
      'avatar': 'assets/image/google_logo.png',
      'unread': false,
    },
  ];

  void _deleteChat(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Chat'),
          content: Text('Are you sure you want to delete this chat?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  chatList.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  final TextEditingController _channel = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Chat>>(
        stream: supabase.from('chats').stream(primaryKey: ['id'])
            // .order('created_at')
            .map((event) => event.map(Chat.fromMap).toList()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final List<Chat> room = snapshot.data;
          print('room: $room');
          if (room.isEmpty) {
            return Center(
              child: Text('No chat available'),
            );
          }
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                  backgroundColor: AppColors.black,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  expandedHeight: MediaQuery.of(context).size.height * 0.13,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                          padding: const EdgeInsets.only(
                              top: 40.0, left: 16.0, right: 16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Chats",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                              ]))),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(10.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: Colors.grey),
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Search',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: text_box(
                          height: MediaQuery.of(context).size.height * 0.06,
                          value: _channel,
                          title: '',
                          hint: 'Channel Name/ID',
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.black),
                        onPressed: () {
                          navigatorKey.currentState!.push(MaterialPageRoute(
                              builder: (context) => workShop()));
                        },
                        child:
                            Text('Join', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    print('room: ${room[index].senderId}');
                    return Dismissible(
                      key: Key(chatList[index]['name']),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      confirmDismiss: (direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Chat'),
                              content: Text(
                                  'Are you sure you want to delete this chat?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text('Yes'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      onDismissed: (direction) {
                        _deleteChat(index);
                      },
                      child: FutureBuilder(
                        future: supabase
                            .from('recruiter')
                            .select()
                            .eq('company_id', room[index].senderId)
                            .single(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: SkeletonLoader());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Column(
                              children: [
                                Text(snapshot.error.toString()),
                                ElevatedButton(
                                    onPressed: () async {
                                      await supabase
                                          .from('recruiter')
                                          .select()
                                          .eq('company_id',
                                              room[index].senderId)
                                          .single();
                                    },
                                    child: Text('Retry')),
                              ],
                            ));
                          } else if (!snapshot.hasData) {
                            return Center(child: Text('No data found'));
                          } else {
                            final Recruiter recruiter =
                                Recruiter.fromJson(snapshot.data, null);
                            return InkWell(
                              onTap: () {
                                navigatorKey.currentState!.push(
                                  MaterialPageRoute(
                                    builder: (context) => chatDetailScreen(
                                      recruiter: recruiter,
                                      chat: room[index],
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      Color(Random().nextInt(0xffffffff)),
                                  child: Text(recruiter.companyName[0]),
                                ),
                                title: Text(
                                  recruiter.companyName,
                                  style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  room[index].lastMessage,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                  childCount: room.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
