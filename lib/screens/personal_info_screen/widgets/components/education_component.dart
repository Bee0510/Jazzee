// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_if_null_operators

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jazzee/backend/userdata/send_personal_info.dart';
import 'package:jazzee/components/button.dart';
import 'package:jazzee/components/text_field.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/models/student/education_model.dart';

import '../../../../components/basic_text.dart';
import '../../../../core/theme/base_color.dart';

class educationComponent extends StatefulWidget {
  @override
  _educationComponentState createState() => _educationComponentState();
}

class _educationComponentState extends State<educationComponent> {
  String? selectedStartYear;
  String? selectedEndYear;
  String? selectedPerformance;
  final TextEditingController _collageController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _streamController = TextEditingController();
  final TextEditingController _performanceController = TextEditingController();
  final List<String> years =
      List<String>.generate(40, (int index) => (2000 + index).toString());
  final List<String> endyears =
      List<String>.generate(40, (int index) => (2000 + index).toString());
  final List<String> performanceOptions = ['CGPA', 'Percentage'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'Add Your Education',
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
                value: _collageController,
                title: 'College/School',
                hint: 'College/School',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your College/School';
                  }
                  return null;
                }),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedStartYear,
                    isExpanded: true,
                    decoration: InputDecoration(
                      hintText: 'Start Year',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: years.map((String year) {
                      return DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedStartYear = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedEndYear,
                    isExpanded: true,
                    decoration: InputDecoration(
                      hintText: 'End Year',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: years.map((String year) {
                      return DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedEndYear = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            text_box(
                value: _degreeController,
                title: 'Degree/Course',
                hint: 'Degree/Course',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Degree/Course';
                  }
                  return null;
                }),
            SizedBox(height: 16),
            text_box(
                value: _streamController,
                title: 'Stream',
                hint: 'Stream',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Stream';
                  }
                  return null;
                }),
            SizedBox(height: 16),
            Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedPerformance,
                    decoration: InputDecoration(
                      hintText: 'Performance',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: performanceOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPerformance = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: text_box(
                      value: _performanceController,
                      title: 'Performance',
                      hint: 'Performance',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Performance';
                        }
                        return null;
                      }),
                ),
              ],
            ),
            Spacer(),
            Button(
                onPressed: () async {
                  await SendPersonalInfo()
                      .sendEducation(
                    _collageController.text,
                    selectedStartYear!,
                    selectedEndYear!,
                    _degreeController.text,
                    _streamController.text,
                    selectedPerformance == 'CGPA'
                        ? _performanceController.text
                        : _performanceController.text + '%',
                  )
                      .then((value) {
                    navigatorKey.currentState!.pop('refresh');
                  });
                },
                color: AppColors.black,
                text: 'Save',
                minimumSize: Size(double.infinity, 50)),
          ],
        ),
      ),
    );
  }
}

class editEducationComponent extends StatefulWidget {
  const editEducationComponent({Key? key, required this.education})
      : super(key: key);
  final Education education;
  @override
  _editEducationComponentState createState() => _editEducationComponentState();
}

class _editEducationComponentState extends State<editEducationComponent> {
  String? selectedStartYear;
  String? selectedEndYear;
  String? selectedPerformance;
  final TextEditingController _collageController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _streamController = TextEditingController();
  final TextEditingController _performanceController = TextEditingController();
  final List<String> years =
      List<String>.generate(40, (int index) => (2000 + index).toString());
  final List<String> endyears =
      List<String>.generate(40, (int index) => (2000 + index).toString());
  final List<String> performanceOptions = ['CGPA', 'Percentage'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'Edit Your Education',
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
              value: _collageController,
              title: 'College/School',
              hint: widget.education.instituteName,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedStartYear,
                    isExpanded: true,
                    decoration: InputDecoration(
                      hintText: widget.education.startYear,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: years.map((String year) {
                      return DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedStartYear = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedEndYear,
                    isExpanded: true,
                    decoration: InputDecoration(
                      hintText: widget.education.endYear,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: years.map((String year) {
                      return DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedEndYear = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            text_box(
              value: _degreeController,
              title: 'Degree/Course',
              hint: widget.education.degreeName,
            ),
            SizedBox(height: 16),
            text_box(
              value: _streamController,
              title: 'Stream',
              hint: widget.education.stream,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedPerformance,
                    decoration: InputDecoration(
                      hintText: 'Performance',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: performanceOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPerformance = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: text_box(
                    value: _performanceController,
                    title: 'Performance',
                    hint: widget.education.marksPerCgpa,
                  ),
                ),
              ],
            ),
            Spacer(),
            Button(
                onPressed: () async {
                  await SendPersonalInfo()
                      .editEducation(
                          _collageController.text.isEmpty
                              ? widget.education.instituteName
                              : _collageController.text,
                          selectedStartYear == null
                              ? widget.education.startYear
                              : selectedStartYear!,
                          selectedEndYear == null
                              ? widget.education.endYear!
                              : selectedEndYear!,
                          _degreeController.text.isEmpty
                              ? widget.education.degreeName
                              : _degreeController.text,
                          _streamController.text.isEmpty
                              ? widget.education.stream
                              : _streamController.text,
                          selectedPerformance == 'CGPA'
                              ? _performanceController.text.isEmpty
                                  ? widget.education.marksPerCgpa
                                  : _performanceController.text
                              : '${_performanceController.text.isEmpty ? widget.education.marksPerCgpa : _performanceController.text}',
                          widget.education.educationId)
                      .then((value) {
                    navigatorKey.currentState!.pop('refresh');
                  });
                },
                color: AppColors.black,
                text: 'Save',
                minimumSize: Size(double.infinity, 50)),
          ],
        ),
      ),
    );
  }
}
