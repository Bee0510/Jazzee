// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jazzee/core/theme/base_color.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/screens/videocall_screen/video_call_screen.dart';

class InterviewCard extends StatelessWidget {
  final String interviewerName;
  final DateTime interviewDateTime;

  InterviewCard({
    required this.interviewerName,
    required this.interviewDateTime,
  });

  bool _canJoinInterview(DateTime currentDateTime) {
    final DateTime fiveMinutesBefore =
        interviewDateTime.subtract(Duration(minutes: 5));
    final DateTime sixHoursAfter = interviewDateTime.add(Duration(hours: 6));
    return currentDateTime.isAfter(fiveMinutesBefore) &&
        currentDateTime.isBefore(sixHoursAfter);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Interview with $interviewerName',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Date: ${interviewDateTime.toLocal().toString().split(' ')[0]}',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                'Time: ${interviewDateTime.toLocal().toString().split(' ')[1].split('.')[0]}',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _canJoinInterview(interviewDateTime)
                          ? AppColors.black
                          : Colors.grey),
                  onPressed: _canJoinInterview(interviewDateTime)
                      ? () {
                          navigatorKey.currentState!.push(
                            MaterialPageRoute(
                              builder: (context) => videoCallScreen(),
                            ),
                          );
                        }
                      : null,
                  child: Text(
                    'Join Interview',
                    style: TextStyle(
                        color: _canJoinInterview(interviewDateTime)
                            ? Colors.white
                            : AppColors.black),
                  ),
                ),
              ),
              if (!_canJoinInterview(interviewDateTime))
                Center(
                  child: Text(
                    'Cannot join interview at this time.',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
