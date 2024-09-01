// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jazzee/components/button.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/models/chats/message_model.dart';
import 'package:jazzee/models/student/student_model.dart';

import '../../../backend/jobdata/send_message.dart';
import '../../../constants.dart/constants.dart';
import '../../../core/theme/base_color.dart';
import '../../../notification/send_notification.dart';

class ScheduleInterviewDialog extends StatefulWidget {
  const ScheduleInterviewDialog(
      {Key? key, required this.message, required this.student})
      : super(key: key);
  final Message message;
  final Student student;
  @override
  _ScheduleInterviewDialogState createState() =>
      _ScheduleInterviewDialogState();
}

class _ScheduleInterviewDialogState extends State<ScheduleInterviewDialog> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  String getFormattedDateTime() {
    if (selectedDate != null && selectedTime != null) {
      final DateTime finalDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      return DateFormat('yyyy-MM-dd HH:mm').format(finalDateTime);
    }
    return 'No date and time selected';
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    final time = format.format(dt);
    print(time.replaceAll('?', ' '));
    return time.replaceAll('?', ' ');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Schedule Interview',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            datetime_section(),
            SizedBox(height: 20),
            Button(
                onPressed: () async {
                  if (_selectedDate != null && _selectedTime != null) {
                    await sendPushMessage(
                        widget.student.token,
                        widget.student.name,
                        'Your Interview has been Scheduled for ' +
                            DateFormat('yMMMd').format(_selectedDate!) +
                            ' at ' +
                            formatTimeOfDay(_selectedTime!));
                    await supabase.from('messages').insert({
                      'chat_id': widget.message.chatId,
                      'receiver_id': widget.message.student_id,
                      'sender_id': widget.message.collage_id,
                      'message_text': 'Your Interview has been Scheduled for ' +
                          DateFormat('yMMMd').format(_selectedDate!) +
                          ' at ' +
                          formatTimeOfDay(_selectedTime!),
                      'collage_id': widget.message.collage_id,
                      'student_id': widget.message.student_id,
                      'sender_type': 'interview',
                    });
                    await supabase
                        .from('chats')
                        .update({
                          'last_message':
                              'Your Interview has been Scheduled for ' +
                                  DateFormat('yMMMd').format(_selectedDate!) +
                                  ' at ' +
                                  formatTimeOfDay(_selectedTime!),
                          'last_time': DateTime.now().toIso8601String(),
                        })
                        .eq('id', widget.message.chatId)
                        .then((value) {
                          navigatorKey.currentState!.pop();
                        });
                  }
                },
                color: AppColors.black,
                text: 'Schedule Interview',
                minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 50)),
          ],
        ),
      ),
    );
  }
}

DateTime? _selectedDate;
TimeOfDay? _selectedTime;

class datetime_section extends StatefulWidget {
  @override
  _datetime_sectionState createState() => _datetime_sectionState();
}

class _datetime_sectionState extends State<datetime_section> {
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16,
                    fontFamily: 'Roboto',
                  )),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 8, right: 40, top: 16, bottom: 16),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: AppColors.primarycolor2,
                      ),
                      SizedBox(width: 8),
                      Text(
                        _selectedDate == null
                            ? 'Date'
                            : DateFormat('dd-MM-yyyy').format(_selectedDate!),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Time',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16,
                    fontFamily: 'Roboto',
                  )),
              GestureDetector(
                onTap: () => _selectTime(context),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 8, right: 40, top: 16, bottom: 16),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        color: AppColors.primarycolor2,
                      ),
                      SizedBox(width: 8),
                      Text(
                        _selectedTime == null
                            ? 'Time'
                            : _selectedTime!.format(context),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
