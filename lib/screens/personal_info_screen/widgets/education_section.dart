// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:jazzee/backend/getdata/get_personal_info.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/screens/personal_info_screen/widgets/components/education_component.dart';

import '../../../constants.dart/constants.dart';
import '../../../models/student/education_model.dart';

class EducationSection extends StatefulWidget {
  const EducationSection({Key? key, required this.educationList})
      : super(key: key);
  final List<Education> educationList;

  @override
  State<EducationSection> createState() => _EducationSectionState();
}

class _EducationSectionState extends State<EducationSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EDUCATION',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.educationList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                  widget.educationList[index].degreeName +
                      ' - ' +
                      widget.educationList[index].stream +
                      '(${widget.educationList[index].startYear} - ${widget.educationList[index].endYear})',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  '${widget.educationList[index].instituteName} · ${widget.educationList[index].marksPerCgpa}',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.grey),
                    onPressed: () {
                      navigatorKey.currentState!.push(MaterialPageRoute(
                          builder: (context) => editEducationComponent(
                              education: widget.educationList[index])));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.grey),
                    onPressed: () async {
                      await supabase
                          .from('education')
                          .delete()
                          .eq('education_id',
                              widget.educationList[index].educationId)
                          .then((value) {
                        setState(() {
                          widget.educationList.removeAt(index);
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
