// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:jazzee/backend/userdata/send_personal_info.dart';
import 'package:jazzee/components/button.dart';
import 'package:jazzee/components/text_field.dart';
import 'package:jazzee/main.dart';
import 'package:intl/intl.dart';
import 'package:jazzee/models/student/projects_model.dart';
import '../../../../components/basic_text.dart';
import '../../../../core/theme/base_color.dart';
import '../../../../models/student/work_experience.dart';

class projectsComponent extends StatefulWidget {
  @override
  _projectsComponentState createState() => _projectsComponentState();
}

class _projectsComponentState extends State<projectsComponent> {
  final _formKey = GlobalKey<FormState>();
  String? selectedStartYear;
  String? selectedEndYear;
  String? selectedPerformance;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _LinkController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _performanceController = TextEditingController();
  bool isCurrentlyOn = false;
  void _toggleCurrentlyOngo(bool? value) {
    setState(() {
      isCurrentlyOn = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'Add Your Project/certificate',
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
                  value: _titleController,
                  title: 'Profile',
                  hint: 'Title',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Profile';
                    }
                    return null;
                  }),
              SizedBox(height: 16),
              text_box(
                value: _LinkController,
                title: 'Organisation',
                hint: 'Project Link',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor: AppColors.black,
                    value: isCurrentlyOn,
                    onChanged: _toggleCurrentlyOngo,
                  ),
                  Text('Currently Ongoing'),
                ],
              ),
              SizedBox(height: 16),
              DateRangePicker(),
              SizedBox(height: 16),
              Container(
                child: TextField(
                  controller: _descriptionController,
                  maxLength: 1000,
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
                          .sendProject(
                              _titleController.text,
                              isCurrentlyOn ? 'Ongoing' : 'Completed',
                              selectedStartDate!,
                              selectedEndDate!,
                              _descriptionController.text,
                              _LinkController.text)
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

class editprojectsComponent extends StatefulWidget {
  const editprojectsComponent({Key? key, required this.projects})
      : super(key: key);
  final Projects projects;
  @override
  _editProjectsComponentState createState() => _editProjectsComponentState();
}

class _editProjectsComponentState extends State<editprojectsComponent> {
  final _formKey = GlobalKey<FormState>();
  String? selectedStartYear;
  String? selectedEndYear;
  String? selectedPerformance;
  late TextEditingController _titleController;
  late TextEditingController _LinkController;
  late TextEditingController _descriptionController;
  late bool isCurrentlyOn;
  void _toggleCurrentlyOngo(bool? value) {
    setState(() {
      isCurrentlyOn = value ?? false;
    });
  }

  @override
  void initState() {
    _titleController =
        TextEditingController(text: widget.projects.projectTitle);
    _LinkController = TextEditingController(text: widget.projects.link);
    _descriptionController =
        TextEditingController(text: widget.projects.projectDescription);
    if (widget.projects.current_status == 'Ongoing') {
      isCurrentlyOn = true;
    } else {
      isCurrentlyOn = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'Edit Your Project/certificate',
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
                  value: _titleController,
                  title: 'Profile',
                  hint: 'Title',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Profile';
                    }
                    return null;
                  }),
              SizedBox(height: 16),
              text_box(
                value: _LinkController,
                title: 'Organisation',
                hint: 'Project Link',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor: AppColors.black,
                    value: isCurrentlyOn,
                    onChanged: _toggleCurrentlyOngo,
                  ),
                  Text('Currently Ongoing'),
                ],
              ),
              SizedBox(height: 16),
              DateRangePicker(),
              SizedBox(height: 16),
              Container(
                child: TextField(
                  controller: _descriptionController,
                  maxLength: 1000,
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
                          .editProject(
                              _titleController.text.isEmpty
                                  ? widget.projects.projectTitle
                                  : _titleController.text,
                              isCurrentlyOn ? 'Ongoing' : 'Completed',
                              selectedStartDate == null
                                  ? widget.projects.startDate
                                  : selectedStartDate!,
                              selectedEndDate == null
                                  ? widget.projects.endDate!
                                  : selectedEndDate!,
                              _descriptionController.text,
                              _LinkController.text.isEmpty
                                  ? widget.projects.link
                                  : _LinkController.text,
                              widget.projects.projectId)
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
      ],
    );
  }
}
