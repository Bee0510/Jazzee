import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/base_color.dart';

String? selectedStartDate;

class tillDatePicker extends StatefulWidget {
  @override
  _tillDatePickerState createState() => _tillDatePickerState();
}

class _tillDatePickerState extends State<tillDatePicker> {
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
                      labelText: 'Apply Till',
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
