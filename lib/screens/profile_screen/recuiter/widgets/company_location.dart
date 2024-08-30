// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jazzee/backend/getdata/get_location.dart';
import 'package:jazzee/components/button.dart';
import 'package:jazzee/constants.dart/constants.dart';
import 'package:jazzee/screens/add_location_screen/add_location_screen.dart';

import '../../../../components/basic_text.dart';
import '../../../../core/theme/base_color.dart';
import '../../../../models/location_model.dart';

class companyLocations extends StatefulWidget {
  const companyLocations({super.key, required this.user});
  final String user;
  @override
  State<companyLocations> createState() => _companyLocationsState();
}

class _companyLocationsState extends State<companyLocations> {
  late Future<List<Locations>> futureLocationResponse;
  @override
  void initState() {
    futureLocationResponse = GetLocation().GetCompanyLocation(widget.user);
    super.initState();
  }

  Future<void> _refresh() async {
    setState(() {
      futureLocationResponse = GetLocation().GetCompanyLocation(widget.user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'Company Locations',
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
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder(
          future: futureLocationResponse,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No data found'));
            } else {
              List<Locations> locations = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    locations.isEmpty
                        ? Center(
                            child: Text('No Location Added Yet'),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: locations.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  basic_text(
                                                      title: locations[index]
                                                          .address1,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          overflow: TextOverflow
                                                              .clip)),
                                                  locations[index].address2 ==
                                                          ''
                                                      ? Container()
                                                      : basic_text(
                                                          title: ', ' +
                                                              locations[index]
                                                                  .address2!,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip)),
                                                ],
                                              ),
                                              basic_text(
                                                  title: locations[index].city +
                                                      ', ' +
                                                      locations[index].state,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      overflow:
                                                          TextOverflow.clip)),
                                              basic_text(
                                                  title:
                                                      locations[index].pinCode,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppColors
                                                          .primarycolor2,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      overflow:
                                                          TextOverflow.clip)),
                                            ]),
                                        IconButton(
                                            onPressed: () async {
                                              await supabase
                                                  .from('locations')
                                                  .delete()
                                                  .eq(
                                                      'location_id',
                                                      locations[index]
                                                          .locationId)
                                                  .then((value) {
                                                _refresh();
                                              });
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ));
                              },
                            ),
                          ),
                    Button(
                        onPressed: () async {
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      addLocationScreen(userId: widget.user)));
                          if (result == 'refresh') {
                            _refresh();
                          }
                        },
                        color: AppColors.black,
                        text: 'Add Location',
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.8,
                            MediaQuery.of(context).size.height * 0.03))
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
