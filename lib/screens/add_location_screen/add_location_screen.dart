// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jazzee/backend/userdata/send_loaction.dart';
import 'package:jazzee/components/text_field.dart';
import 'package:jazzee/main.dart';

import '../../components/basic_text.dart';
import '../../components/button.dart';
import '../../core/theme/base_color.dart';

class addLocationScreen extends StatefulWidget {
  const addLocationScreen({Key? key, required this.userId}) : super(key: key);
  final String userId;
  @override
  State<addLocationScreen> createState() => _addLocationScreenState();
}

class _addLocationScreenState extends State<addLocationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  final Map<String, List<String>> countryStateMap = {
    'USA': ['California', 'Texas', 'Florida'],
    'India': ['Maharashtra', 'Karnataka', 'Tamil Nadu', 'Odisha'],
  };

  final Map<String, List<String>> stateCityMap = {
    'California': ['Los Angeles', 'San Francisco', 'San Diego'],
    'Texas': ['Houston', 'Dallas', 'Austin'],
    'Florida': ['Miami', 'Orlando', 'Tampa'],
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur'],
    'Karnataka': ['Bangalore', 'Mysore', 'Mangalore'],
    'Tamil Nadu': ['Chennai', 'Coimbatore', 'Madurai'],
    'Odisha': ['Bhubaneswar', 'Cuttack', 'Puri', 'Rourkela'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'Add Location',
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              text_box(
                value: _address1Controller,
                title: 'address',
                hint: 'Address 1',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              text_box(
                  value: _address2Controller,
                  title: 'address',
                  hint: 'Address 2'),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: '-- Select Your Country ---',
                  hintStyle:
                      TextStyle(fontFamily: 'Roboto', color: Colors.grey),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primarycolor2)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primarycolor2),
                  ),
                ),
                value: selectedCountry,
                items: countryStateMap.keys.map((country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCountry = value;
                    selectedState = null;
                    selectedCity = null;
                  });
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: '-- Select Your State ---',
                  hintStyle:
                      TextStyle(fontFamily: 'Roboto', color: Colors.grey),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primarycolor2)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primarycolor2),
                  ),
                ),
                value: selectedState,
                items: selectedCountry != null
                    ? countryStateMap[selectedCountry]!.map((state) {
                        return DropdownMenuItem<String>(
                          value: state,
                          child: Text(state),
                        );
                      }).toList()
                    : [],
                onChanged: (value) {
                  setState(() {
                    selectedState = value;
                    selectedCity = null;
                  });
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: '-- Select Your City/Town ---',
                  hintStyle:
                      TextStyle(fontFamily: 'Roboto', color: Colors.grey),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primarycolor2)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primarycolor2),
                  ),
                ),
                value: selectedCity,
                items: selectedState != null
                    ? stateCityMap[selectedState]!.map((city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList()
                    : [],
                onChanged: (value) {
                  setState(() {
                    selectedCity = value;
                  });
                },
              ),
              SizedBox(height: 16),
              text_box(
                value: _pincodeController,
                title: 'Pincode',
                hint: 'Pincode',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter pincode';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              Button(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        selectedCountry != null &&
                        selectedState != null &&
                        selectedCity != null) {
                      await SendLocationInfo()
                          .sendLocation(
                              widget.userId,
                              _address1Controller.text,
                              _address2Controller.text,
                              _pincodeController.text,
                              selectedCity!,
                              selectedState!,
                              selectedCountry!)
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
