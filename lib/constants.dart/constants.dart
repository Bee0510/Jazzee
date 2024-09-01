import 'package:jazzee/core/utils/shared_preference.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
String role_type = SharedPreferencesService.getString('role')!;
const appId = 'af079c6d307c42f1b99188750531ceb4';
const token =
    '007eJxTYFinJiYXtX72d8PFB1a66VXEWKVf3KLFVv7XWkVWY9NplWMKDIlpBuaWyWYpxgbmySZGaYZJlpaGFhbmpgamxobJqUkmLGZX0hoCGRnS5dKZGBkgEMRnY/BKrKpKTWVgAADUmx0d';
