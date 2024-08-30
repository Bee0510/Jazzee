import 'package:jazzee/models/location_model.dart';
import '../../constants.dart/constants.dart';

class GetLocation {
  Future<Locations> GetUserLocation(String userId) async {
    try {
      final List<Map<String, dynamic>> _locations =
          await supabase.from('locations').select().eq('user_id', userId);
      return Locations.fromJson(_locations[0]);
    } catch (e) {
      print('Error getting locations: $e');
      return Locations(
        locationId: '',
        userId: '',
        address1: '',
        address2: '',
        pinCode: '',
        city: '',
        state: '',
        country: '',
      );
    }
  }

  Future<List<Locations>> GetCompanyLocation(String userId) async {
    try {
      final List<Map<String, dynamic>> _locations =
          await supabase.from('locations').select().eq('user_id', userId);
      return _locations.map((e) => Locations.fromJson(e)).toList();
    } catch (e) {
      print('Error getting locations: $e');
      return [];
    }
  }
}
