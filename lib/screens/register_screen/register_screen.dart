// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:jazzee/api/get_cities.dart';
import 'package:jazzee/backend/auth/register.dart';
import 'package:jazzee/backend/getdata/get_all_collage.dart';
import 'package:jazzee/components/text_field.dart';
import 'package:jazzee/core/theme/base_color.dart';
import 'package:jazzee/core/theme/base_font';
import 'package:jazzee/main.dart';
import 'package:jazzee/navbar.dart';

import '../../../../constants.dart/constants.dart';

class registerScreen extends StatefulWidget {
  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phone_noController = TextEditingController();
  final TextEditingController collageRollController = TextEditingController();
  final TextEditingController collageCodeController = TextEditingController();
  final TextEditingController _GSTINController = TextEditingController();
  String _roleType = 'students';
  String? _selectedCollageName;
  String _selectedCollageId = '';
  late Future<List<Map<String, dynamic>>> collages;
  late Future<List<City>?> cities;

  List<Map<String, dynamic>> filteredCollages = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    collages = getAllCollage().get_all_collage();
    cities = getAllCities().fetchCities('IN');
    collages.then((data) {
      setState(() {
        filteredCollages = data;
      });
    });
  }

  void filterSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredCollages = [...filteredCollages]; // Show all collages
      });
    } else {
      setState(() {
        filteredCollages = filteredCollages
            .where((collage) => collage['Collage Name']
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: FutureBuilder(
            future: Future.wait([collages, cities]),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text('Fetching Institute Details. Please Wait')
                  ],
                ));
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Center(child: Text('No Address available'));
              } else {
                final List<Map<String, dynamic>> data = snapshot.data[0];
                final List<City>? cities = snapshot.data[1];
                print(cities);
                print(data);
                return Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: AppTextStyles.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Please, register in to your account.\nIt takes less than one minute.',
                          style: AppTextStyles.mediumRegular
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 40),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12, width: 1),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: DropdownButtonFormField<String>(
                            value: _roleType.isNotEmpty ? _roleType : null,
                            isExpanded: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _roleType = newValue!;
                              });
                            },
                            items: <String>['students', 'recruiter', 'collage']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: AppColors.black,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        text_box(
                          value: nameController,
                          title: 'Name',
                          height: MediaQuery.of(context).size.height * 0.07,
                          hint:
                              'Name of the ${_roleType == 'recruiter' ? 'Company' : _roleType}',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        text_box(
                          value: phone_noController,
                          title: 'Phone Number',
                          height: MediaQuery.of(context).size.height * 0.07,
                          hint: 'Contact Number',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        text_box(
                          value: emailController,
                          title: 'Email',
                          height: MediaQuery.of(context).size.height * 0.07,
                          hint:
                              'Email of the ${_roleType == 'recruiter' ? 'Company' : _roleType}',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        _roleType == 'recruiter'
                            ? text_box(
                                value: _GSTINController,
                                title: 'Email',
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                hint: 'Company\'s GSTIN Number',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid GSTIN Number';
                                  }
                                  return null;
                                },
                              )
                            : Container(),
                        const SizedBox(height: 20),
                        _roleType == 'students'
                            ? Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black12, width: 1),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      value: _selectedCollageName,
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        hintText:
                                            '-- Select Your Institute ---',
                                        hintStyle: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Colors.grey),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedCollageName = newValue!;
                                          _selectedCollageId = data.firstWhere(
                                              (element) =>
                                                  element['Collage Name'] ==
                                                  newValue)['Collage ID'];
                                        });
                                      },
                                      items: filteredCollages.map((e) {
                                        return DropdownMenuItem<String>(
                                          value: e['Collage Name'],
                                          child: Text(e['Collage Name']),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  text_box(
                                    value: collageRollController,
                                    title: 'Password',
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    hint: 'College Roll Number',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter valid roll number';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  text_box(
                                    value: collageRollController,
                                    title: 'Password',
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    hint: 'College Roll Number',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter valid roll number';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              )
                            : Container(),
                        const SizedBox(height: 20),
                        _roleType == 'collage'
                            ? text_box(
                                value: collageCodeController,
                                title: 'Password',
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                hint: 'Collage Code',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter valid code';
                                  }
                                  return null;
                                },
                              )
                            : Container(),
                        const SizedBox(height: 20),
                        text_box(
                          value: passwordController,
                          title: 'Password',
                          height: MediaQuery.of(context).size.height * 0.07,
                          hint: 'Password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          obsureText: true,
                        ),
                        SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                await Register()
                                    .register(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  roleType: _roleType,
                                  name: nameController.text,
                                  phone_no: phone_noController.text,
                                  collage_id: _selectedCollageId,
                                  collage_name: _selectedCollageName,
                                  roll_no: collageRollController.text,
                                  college_code: collageCodeController.text,
                                  gst: _GSTINController.text,
                                )
                                    .then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Registered Successfully. Please Verify You Email'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  navigatorKey.currentState!.pop();
                                });
                                // final session = supabase.auth.currentSession;
                                // if (session != null) {
                                //   navigatorKey.currentState!.pushAndRemoveUntil(
                                //       MaterialPageRoute(
                                //           builder: (context) => navBar()),
                                //       (route) => false);
                                // }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.black,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Register',
                              style: AppTextStyles.mediumRegular.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              navigatorKey.currentState!.pop();
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Already have an account? ",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  TextSpan(
                                    text: 'Log In',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
