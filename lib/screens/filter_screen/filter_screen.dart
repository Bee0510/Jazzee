// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jazzee/components/button.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/models/student/job_filter_model.dart';
import 'package:jazzee/screens/personal_info_screen/widgets/components/skills_component.dart';

import '../../components/basic_text.dart';
import '../../core/theme/base_color.dart';

class filtersScreen extends StatefulWidget {
  @override
  _filtersScreenState createState() => _filtersScreenState();
}

class _filtersScreenState extends State<filtersScreen> {
  bool asPerMyPreferences = false;
  bool workFromHome = false;
  bool partTime = false;
  bool onSite = false;
  List<String> selectedSkills = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'Filters',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              title: Row(
                children: [
                  Text('As per my'),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'preferences',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              value: asPerMyPreferences,
              onChanged: (value) {
                setState(() {
                  asPerMyPreferences = value!;
                });
              },
            ),
            Divider(),
            TextButton(
              onPressed: () async {
                final List<String> selectedSkills = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => skillsComponent(
                      isFilter: true,
                    ),
                  ),
                );
                if (selectedSkills != null) {
                  setState(() {
                    this.selectedSkills = selectedSkills;
                  });
                }
              },
              child: Text(
                '+ Select Skills',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            Wrap(
              spacing: 10,
              children: selectedSkills
                  .map((skill) => Chip(
                        label: Text(skill),
                        onDeleted: () {
                          setState(() {
                            selectedSkills.remove(skill);
                          });
                        },
                      ))
                  .toList(),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Remote',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                Checkbox(
                  value: workFromHome,
                  activeColor: AppColors.black,
                  onChanged: (bool? value) {
                    setState(() {
                      workFromHome = value ?? false;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hybrid',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                Checkbox(
                  value: partTime,
                  activeColor: AppColors.black,
                  onChanged: (bool? value) {
                    setState(() {
                      partTime = value ?? false;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'On-Site',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                Checkbox(
                  value: onSite,
                  activeColor: AppColors.black,
                  onChanged: (bool? value) {
                    setState(() {
                      onSite = value ?? false;
                    });
                  },
                ),
              ],
            ),
            Divider(),
            Text('Monthly Stipend (INR)',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                _stipendButton(context, '₹ 2000'),
                _stipendButton(context, '₹ 4000'),
                _stipendButton(context, '₹ 6000'),
                _stipendButton(context, '₹ 8000'),
                _stipendButton(context, '₹ 10000'),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button(
                    onPressed: () {},
                    color: AppColors.black,
                    text: 'Reset',
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.4,
                        MediaQuery.of(context).size.height * 0.06)),
                SizedBox(width: 10),
                Button(
                    onPressed: () async {
                      navigatorKey.currentState!.pop(JobFilters(
                          jobTypes: [
                            if (workFromHome) 'Remote',
                            if (partTime) 'Hybrid',
                            if (onSite) 'On-Site'
                          ],
                          salary: selectedAmount!.replaceAll('₹ ', ''),
                          skills: selectedSkills));
                    },
                    color: AppColors.black,
                    text: 'Apply All',
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.4,
                        MediaQuery.of(context).size.height * 0.06)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String? selectedAmount;

  Widget _stipendButton(BuildContext context, String amount) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedAmount = amount;
        });
        print('Selected Amount: $amount');
      },
      child: Text(amount,
          style: TextStyle(
              color: selectedAmount == amount ? Colors.white : Colors.black)),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: selectedAmount == amount
            ? AppColors.black
            : Colors.white, // Highlight selected button
      ),
    );
  }
}
