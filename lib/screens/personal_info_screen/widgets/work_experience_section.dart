// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../constants.dart/constants.dart';
import '../../../main.dart';
import '../../../models/student/work_experience.dart';
import 'components/work_experience_component.dart';

class WorkExperienceSection extends StatefulWidget {
  const WorkExperienceSection({Key? key, required this.workexperienceList})
      : super(key: key);
  final List<WorkExperience> workexperienceList;
  @override
  State<WorkExperienceSection> createState() => _WorkExperienceSectionState();
}

class _WorkExperienceSectionState extends State<WorkExperienceSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'WORK EXPERIENCE',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.workexperienceList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(widget.workexperienceList[index].designation,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  '${widget.workexperienceList[index].organization} · ${widget.workexperienceList[index].jobLocation} · ${widget.workexperienceList[index].startDate} - ${widget.workexperienceList[index].endDate}',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.grey),
                    onPressed: () async {
                      navigatorKey.currentState!.push(MaterialPageRoute(
                          builder: (context) => editWorkExperienceComponent(
                                workExperience:
                                    widget.workexperienceList[index],
                              )));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.grey),
                    onPressed: () async {
                      await supabase
                          .from('work_experience')
                          .delete()
                          .eq('work_exp_id',
                              widget.workexperienceList[index].workExpId)
                          .then((value) {
                        setState(() {
                          widget.workexperienceList.removeAt(index);
                        });
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
