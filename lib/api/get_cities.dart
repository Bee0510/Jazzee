import 'dart:convert';
import 'package:http/http.dart' as http;

class City {
  final int id;
  final String name;

  City({
    required this.id,
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class getAllCities {
  final String apiKey = 'X-CSCAPI-KEY';
  final String baseUrl = 'https://api.countrystatecity.in/v1/countries';

  // Method to fetch cities for a given country code
  Future<List<City>?> fetchCities(String countryCode) async {
    var headers = {
      'X-CSCAPI-KEY': apiKey,
    };

    var url = Uri.parse('$baseUrl/$countryCode/cities');

    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<City> cities =
            jsonList.map((json) => City.fromJson(json)).toList();
        return cities;
      } else {
        print('Failed to load cities. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred while fetching cities: $e');
      return null;
    }
  }
}
