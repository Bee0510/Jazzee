import 'package:jazzee/core/utils/shared_preference.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
String role_type = SharedPreferencesService.getString('role')!;
const appId = 'af079c6d307c42f1b99188750531ceb4';
const token =
    '007eJxTYJBufXMk8PHfd58kZ3Sn5JWazLs6eZGiKXOjhPOc7js3oxsUGBLTDMwtk81SjA3Mk02M0gyTLC0NLSzMTQ1MjQ2TU5NM0ldfTGsIZGQokhJlYIRCEJ+VwSM1JyefgQEAu7kf3g==';
