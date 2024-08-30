// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jazzee/core/theme/base_color.dart';

import '../../../models/student/student_model.dart';

class PersonalDetailsSection extends StatefulWidget {
  const PersonalDetailsSection({Key? key, this.user}) : super(key: key);
  final Student? user;

  @override
  State<PersonalDetailsSection> createState() => _PersonalDetailsSectionState();
}

class _PersonalDetailsSectionState extends State<PersonalDetailsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PERSONAL DETAILS',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user!.name,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primarycolor2),
                  ),
                  Text(widget.user!.email, style: TextStyle(fontSize: 14)),
                  Text(widget.user!.phoneNo, style: TextStyle(fontSize: 14)),
                  Text('Subdega', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.grey),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
