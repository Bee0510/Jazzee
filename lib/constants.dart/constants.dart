import 'package:jazzee/core/utils/shared_preference.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
String role_type = SharedPreferencesService.getString('role')!;
const appId = 'af079c6d307c42f1b99188750531ceb4';
const token =
    '007eJxTYDDj3bD815wDi9g3WQYWVAvFMkd4/J6lb99dJ7Y+8nzayRAFhsQ0A3PLZLMUYwPzZBOjNMMkS0tDCwtzUwNTY8Pk1CSTB1mX0xoCGRm4CrsZGKEQxGdj8EqsqkpNZWAAABWfHpU=';
