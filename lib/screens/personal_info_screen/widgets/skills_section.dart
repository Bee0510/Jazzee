// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../constants.dart/constants.dart';
import '../../../models/student/skills_model.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({Key? key, required this.skillsList}) : super(key: key);
  final List<Skill> skillsList;
  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SKILLS',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: widget.skillsList.map((skill) {
            return Chip(
              label: Text(skill.skillName),
              labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              deleteIcon: Icon(
                Icons.close,
                size: 14,
              ),
              onDeleted: () async {
                await supabase.from('skills').delete().eq(
                    'skill_id',
                    widget
                        .skillsList[widget.skillsList.indexOf(skill)].skillId);
                setState(() {
                  widget.skillsList.remove(skill);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
