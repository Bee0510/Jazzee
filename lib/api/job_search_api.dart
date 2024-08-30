import 'dart:convert';
import 'package:http/http.dart' as http;

class jobSearchApi {
  final String apiUrl = 'https://linkedin-data-api.p.rapidapi.com/search-jobs';

  Future<dynamic> search_Jobs({
    required String keywords,
    required String locationId,
    String datePosted = 'anyTime',
    String sort = 'mostRelevant',
    String company = '',
    String jobType = '',
    String experienceLevel = '',
    String remote = '',
  }) async {
    // Build the query parameters
    Map<String, String> queryParams = {
      'keywords': keywords,
      'locationId': locationId,
      'datePosted': datePosted,
      'sort': sort,
    };

    // Optional filters
    if (company.isNotEmpty) queryParams['company'] = company;
    if (jobType.isNotEmpty) queryParams['jobType'] = jobType;
    if (experienceLevel.isNotEmpty)
      queryParams['experienceLevel'] = experienceLevel;
    if (remote.isNotEmpty) queryParams['remote'] = remote;

    // Create the URI with query parameters
    var uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);

    // Make the GET request
    final response = await http.get(
      uri,
      headers: {
        'x-rapidapi-key': '2f2b5e94afmshfedd803c8f48cd1p1823e2jsn39c3413266da',
        'x-rapidapi-host': 'linkedin-data-api.p.rapidapi.com',
        'Accept': 'application/json',
      },
    );

    // Handle the response
    if (response.statusCode == 200) {
      // If the request was successful, parse the JSON response
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse;
    } else {
      // If the request failed, handle the error
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}
