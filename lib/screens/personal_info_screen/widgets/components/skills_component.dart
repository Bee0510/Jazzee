// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_if_null_operators
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jazzee/components/text_field.dart';

import '../../../../backend/userdata/send_personal_info.dart';
import '../../../../components/basic_text.dart';
import '../../../../components/button.dart';
import '../../../../core/theme/base_color.dart';
import '../../../../main.dart';

class skillsComponent extends StatefulWidget {
  skillsComponent({Key? key, this.isFilter}) : super(key: key);
  bool? isFilter = false;
  @override
  _skillsComponentState createState() => _skillsComponentState();
}

class _skillsComponentState extends State<skillsComponent> {
  final List<String> allSkills = [
    'Flutter',
    'React',
    'Angular',
    'Python',
    'Django',
    'Node.js',
    'Java',
    'Kotlin',
    'Swift',
    'C++',
    'JavaScript',
    'HTML',
    'CSS',
    'SQL',
    'MongoDB'
  ];

  List<String> filteredSkills = [];
  List<String> selectedSkills = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredSkills = allSkills;
  }

  void filterSkills(String query) {
    final List<String> filtered = allSkills
        .where((skill) => skill.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredSkills = filtered;
    });
  }

  void addSkill(String skill) {
    if (!selectedSkills.contains(skill)) {
      setState(() {
        selectedSkills.add(skill);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'Add Your Skills',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
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
            text_box(
              value: searchController,
              height: MediaQuery.of(context).size.height * 0.06,
              title: 'Search',
              hint: 'Search for a skill',
              onChanged: (value) {
                setState(() {
                  filterSkills(value);
                });
              },
            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100]),
                child: ListView.builder(
                  itemCount: filteredSkills.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredSkills[index]),
                      onTap: () async {
                        if (widget.isFilter == true) {
                          navigatorKey.currentState!
                              .pop([filteredSkills[index]]);
                        } else {
                          addSkill(filteredSkills[index]);
                          await SendPersonalInfo()
                              .sendSkill(filteredSkills[index], '')
                              .then((value) {
                            navigatorKey.currentState!.pop('refresh');
                          });
                        }
                      },
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Selected Skills:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Display selected skills
            Expanded(
              child: ListView.builder(
                itemCount: selectedSkills.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(selectedSkills[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          selectedSkills.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            // Button(
            //     onPressed: () async {
            //       await SendPersonalInfo()
            //           .sendSkill(selectedSkills[index], skill_level)
            //           .then((value) {
            //         navigatorKey.currentState!.pop('refresh');
            //       });
            //     },
            //     color: AppColors.black,
            //     text: 'Save',
            //     minimumSize: Size(double.infinity, 50)),
          ],
        ),
      ),
    );
  }
}
