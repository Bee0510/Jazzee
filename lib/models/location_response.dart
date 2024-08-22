class LocResponse {
  final int status;
  final bool error;
  final LocMessages messages;

  LocResponse(
      {required this.status, required this.error, required this.messages});

  factory LocResponse.fromJson(Map<String, dynamic> json) {
    return LocResponse(
      status: json['status'] ?? 0,
      error: json['error'] ?? false,
      messages: LocMessages.fromJson(json['messages'] ?? {}),
    );
  }
}

class LocMessages {
  final String responsecode;
  final List<StateData> data;

  LocMessages({required this.responsecode, required this.data});

  factory LocMessages.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List? ?? [];
    List<StateData> dataList = list.map((i) => StateData.fromJson(i)).toList();

    return LocMessages(
      responsecode: json['responsecode'] ?? '',
      data: dataList,
    );
  }
}

class StateData {
  final String stateId;
  final String stateName;
  final List<CityData> cities;

  StateData(
      {required this.stateId, required this.stateName, required this.cities});

  factory StateData.fromJson(Map<String, dynamic> json) {
    var list = json['cities'] as List? ?? [];
    List<CityData> cityList = list.map((i) => CityData.fromJson(i)).toList();

    return StateData(
      stateId: json['state_id'] ?? '',
      stateName: json['state_name'] ?? '',
      cities: cityList,
    );
  }
}

class CityData {
  final String cityId;
  final String cityName;
  final List<String> pincodes;

  CityData(
      {required this.cityId, required this.cityName, required this.pincodes});

  factory CityData.fromJson(Map<String, dynamic> json) {
    var list = json['pincodes'] as List? ?? [];
    List<String> pincodeList = list.map((i) => i.toString()).toList();

    return CityData(
      cityId: json['city_id'] ?? '',
      cityName: json['city_name'] ?? '',
      pincodes: pincodeList,
    );
  }
}
