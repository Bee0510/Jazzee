// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_if_null_operators

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jazzee/backend/userdata/send_personal_info.dart';
import 'package:jazzee/components/button.dart';
import 'package:jazzee/components/text_field.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/models/student/education_model.dart';
import 'package:intl/intl.dart';
import '../../../../components/basic_text.dart';
import '../../../../core/theme/base_color.dart';
import '../../../../models/student/work_experience.dart';

class workExperienceComponent extends StatefulWidget {
  @override
  _workExperienceComponentState createState() =>
      _workExperienceComponentState();
}

class _workExperienceComponentState extends State<workExperienceComponent> {
  final _formKey = GlobalKey<FormState>();
  String? selectedStartYear;
  String? selectedEndYear;
  String? selectedPerformance;
  final TextEditingController _profileController = TextEditingController();
  final TextEditingController _organisationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _performanceController = TextEditingController();
  bool isWorkFromHome = false;
  void _toggleCurrentlyWorking(bool? value) {
    setState(() {
      isWorkFromHome = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'Add Your Work Experience',
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text_box(
                  value: _profileController,
                  title: 'Profile',
                  hint: 'Job Profile',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Profile';
                    }
                    return null;
                  }),
              SizedBox(height: 16),
              text_box(
                  value: _organisationController,
                  title: 'Organisation',
                  hint: 'Organisation',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Organisation';
                    }
                    return null;
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor: AppColors.black,
                    value: isWorkFromHome,
                    onChanged: _toggleCurrentlyWorking,
                  ),
                  Text('Is Work From Home'),
                ],
              ),
              SizedBox(height: 16),
              DateRangePicker(),
              SizedBox(height: 16),
              Container(
                child: TextField(
                  controller: _descriptionController,
                  maxLength: 300,
                  minLines: 1,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: AppColors.primarycolor2),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primarycolor2)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primarycolor2),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Spacer(),
              Button(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        selectedStartDate != null) {
                      await SendPersonalInfo()
                          .sendWorkExperience(
                        _profileController.text,
                        _organisationController.text,
                        isWorkFromHome ? 'Remote' : 'On-Site',
                        selectedStartDate!,
                        selectedEndDate == null ? 'Present' : selectedEndDate!,
                        _descriptionController.text,
                      )
                          .then((value) {
                        navigatorKey.currentState!.pop('refresh');
                      });
                    }
                  },
                  color: AppColors.black,
                  text: 'Save',
                  minimumSize: Size(double.infinity, 50)),
            ],
          ),
        ),
      ),
    );
  }
}

class editWorkExperienceComponent extends StatefulWidget {
  const editWorkExperienceComponent({Key? key, required this.workExperience})
      : super(key: key);
  final WorkExperience workExperience;
  @override
  _editWorkExperienceComponentState createState() =>
      _editWorkExperienceComponentState();
}

class _editWorkExperienceComponentState
    extends State<editWorkExperienceComponent> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _profileController;
  late TextEditingController _organisationController;
  late TextEditingController _descriptionController;
  late bool isWorkFromHome;
  void _toggleCurrentlyWorking(bool? value) {
    setState(() {
      isWorkFromHome = value ?? false;
    });
  }

  @override
  void initState() {
    if (widget.workExperience.jobLocation == 'Remote') {
      isWorkFromHome = true;
    } else {
      isWorkFromHome = false;
    }
    _profileController =
        TextEditingController(text: widget.workExperience.designation);
    _organisationController =
        TextEditingController(text: widget.workExperience.organization);
    _descriptionController =
        TextEditingController(text: widget.workExperience.workDescription);
    setState(() {
      selectedStartDate = widget.workExperience.startDate;
      selectedEndDate = widget.workExperience.endDate;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'Edit Your Work Experience',
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text_box(
                  value: _profileController,
                  title: 'Profile',
                  hint: 'Job Profile',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Profile';
                    }
                    return null;
                  }),
              SizedBox(height: 16),
              text_box(
                  value: _organisationController,
                  title: 'Organisation',
                  hint: 'Organisation',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Organisation';
                    }
                    return null;
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor: AppColors.black,
                    value: isWorkFromHome,
                    onChanged: _toggleCurrentlyWorking,
                  ),
                  Text('Is Work From Home'),
                ],
              ),
              SizedBox(height: 16),
              DateRangePicker(),
              SizedBox(height: 16),
              Container(
                child: TextField(
                  controller: _descriptionController,
                  maxLength: 300,
                  minLines: 1,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: AppColors.primarycolor2),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primarycolor2)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primarycolor2),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Spacer(),
              Button(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        selectedStartDate != null) {
                      await SendPersonalInfo()
                          .editWorkExperience(
                              _profileController.text.isEmpty
                                  ? widget.workExperience.designation
                                  : _profileController.text,
                              _organisationController.text.isEmpty
                                  ? widget.workExperience.organization
                                  : _organisationController.text,
                              isWorkFromHome ? 'Remote' : 'On-Site',
                              selectedStartDate == null
                                  ? widget.workExperience.startDate
                                  : selectedStartDate!,
                              selectedEndDate == null
                                  ? 'Present'
                                  : selectedEndDate == null
                                      ? widget.workExperience.endDate!
                                      : selectedEndDate!,
                              _descriptionController.text.isEmpty
                                  ? widget.workExperience.workDescription!
                                  : _descriptionController.text,
                              widget.workExperience.workExpId)
                          .then((value) {
                        navigatorKey.currentState!.pop('refresh');
                      });
                    }
                  },
                  color: AppColors.black,
                  text: 'Save',
                  minimumSize: Size(double.infinity, 50)),
            ],
          ),
        ),
      ),
    );
  }
}

String? selectedStartDate;
String? selectedEndDate;
bool isCurrentlyWorking = false;

class DateRangePicker extends StatefulWidget {
  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedStartDate = DateFormat('yyyy-MM-dd').format(picked);
        startDateController.text = selectedStartDate!;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    if (isCurrentlyWorking) return;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedEndDate = DateFormat('yyyy-MM-dd').format(picked);
        endDateController.text = selectedEndDate!;
      });
    }
  }

  void _toggleCurrentlyWorking(bool? value) {
    setState(() {
      isCurrentlyWorking = value ?? false;
      if (isCurrentlyWorking) {
        endDateController.text = 'Present';
        selectedEndDate = 'Present';
      } else {
        endDateController.clear();
        selectedEndDate = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => _selectStartDate,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                child: TextField(
                  controller: startDateController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            _selectStartDate(context);
                          },
                          icon: Icon(Icons.calendar_today)),
                      labelText: 'Start Date',
                      labelStyle: TextStyle(color: AppColors.primarycolor2),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primarycolor2),
                      )),
                  readOnly: true,
                ),
              ),
            ),
            SizedBox(width: 16),
            InkWell(
              onTap: () => _selectEndDate(context),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                child: TextField(
                  controller: endDateController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            _selectEndDate(context);
                          },
                          icon: Icon(Icons.calendar_today)),
                      labelText: 'End Date',
                      labelStyle: TextStyle(color: AppColors.primarycolor2),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primarycolor2),
                      )),
                  readOnly: true,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: isCurrentlyWorking,
              activeColor: AppColors.black,
              onChanged: _toggleCurrentlyWorking,
            ),
            Text('I am currently working'),
          ],
        ),
      ],
    );
  }
}
