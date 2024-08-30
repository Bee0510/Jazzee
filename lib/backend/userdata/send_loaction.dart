import '../../constants.dart/constants.dart';

class SendLocationInfo {
  Future<void> sendLocation(
    String user_id,
    String address1,
    String address2,
    String pinCode,
    String city,
    String state,
    String country,
  ) async {
    try {
      await supabase.from('locations').insert({
        'user_id': user_id,
        'address1': address1,
        'address2': address2,
        'pin_code': pinCode,
        'city': city,
        'state': state,
        'country': country,
      });
    } catch (e) {
      print('Error sending location: $e');
    }
  }
}
