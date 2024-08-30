import 'package:flutter/material.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({Key? key, required this.skillsList}) : super(key: key);
  final List<String> skillsList;
  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.skillsList.isEmpty
            ? Container()
            : Text(
                'Selected Skills:',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: widget.skillsList.map((skill) {
            return Chip(
              label: Text(skill),
              labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              deleteIcon: Icon(
                Icons.close,
                size: 14,
              ),
              onDeleted: () async {
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
