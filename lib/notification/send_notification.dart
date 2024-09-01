import 'dart:convert';

import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

Future<void> sendPushMessage(String token, String title, String body) async {
  try {
    final String servertoken = await GetServerKey().getServerKeyToken();
    await http.post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/jazzee-9b074/messages:send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $servertoken',
      },
      body: jsonEncode({
        "message": {
          "token": token,
          "notification": {
            "body": body,
            "title": title,
          }
        }
      }),
    );
    print("Push notification sent successfully");
  } catch (e) {
    print(e.toString());
    print("Error sending push notification");
  }
}

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "jazzee-9b074",
          "private_key_id": "8cf9a47baa0da072ac82ac547fd9dd8a1ffc91bb",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDcFXt6TETFK93t\n0DYwYJETbVxiIqElL8mCYfU73OYqF8AUwq6hjtWGsnUxkgnnX5huG/ZRmLi/AVv2\nY0mi9H4z24uQCxOjokan/ehUqPb8SPVDKraD5ctESW+STXkgtl7H9wLq4pdSd6hZ\n9tpVexuzPw6WEIZJPcDaCdezYN92RHhBQui1KYGkEEIFQvLX+k9rXeZB7phHM95+\n2CWcEb3EzvMMX/H5M9S+umRjGNpjhaEg+CTMR+Bj4ks++Xu8g7Q5JR/cjn7nho7h\nUL8ovEBtcWXSSAQIAnGXvADkaogM6KYA3VePwi4BtfUlzGduF+sxX8Ba3S44CVoj\nLsr3GNNBAgMBAAECggEADRZanI1Vgj4XY+a/mi/b4K0I/dhI/zZGGYfsC9kZIhlT\nIEjqwTZbseIB1bv1Snok99iXf1xWvBuqFXmWWDzewQRbWmpLithXCEgGh/ubjalk\nVaVVa3wqPWTP4CzVjkxEpZ0ljMSDCByPznhp8lmwQ3/1ROzgTLxXMAAUK266yxmv\nT8ivnd2DLuxNFO2QwUZOzVkuezacYn4B/F8RzxicplSdiDnQHAg2RBBZMaC9IxJ4\nHhesv5MXhYlNwNMSuReH2nb52H61VKbPZN3p/wMbqMTkQexSRuexYL2RKn17UCuG\nlxNFy+l67EbuJCJoCFrgQtUviV4MOyqWCml+dOKkGwKBgQD4Ao6z/RMMwgqh2kP7\neyHuBO+PFLVjp5ZLGzHFoNu8DwtV1584AIsiEq7P1EbVHEALt7l5VRP3r15YmVba\nPlDkWIWiW365MgMBMuXwYZWxFVDoeL++Y/MMa1IPqoOMHdotN1UyQbmeAtI6/d/6\n0PkSY0T3Rh05q3Ma4+BHbq1dNwKBgQDjLJtZafFGB3cws3RlD/w7BEVteVQqEtzQ\nRM4ucOthCgOxCFiyfjR5l6FjcjelRpjU5/ulFqEAMP8B9Hvv4bNFHDmQkRYLzBRk\n5hyrRF5RhG490akw234St3KbwBsLXySf646BCbiK40yJ+BDvrbDl8KkQn6HXacBD\naF7vBMBPRwKBgDC0H94Mxt7shDYArPUH20PoyDqq8Gwfjw40yvNqgXxO4AT9kRDo\nWmpYjOfXYgmbwKAMdmnzYTZ0w+xWQI4fSrdtAuE9Yodv4NMtcaZhI4phC0B75fu3\nmRVJRhY5gBfWDPBwO1ThP1heaXaYQJH6087em76LkFWw66vOME8W1wjFAoGBAMC/\n+leVUkfu0ayatumA9KxGZXoLdeP0+TIlDyPMX4qIarVstYVNG80HYMH2CUzMZ6RN\n6PAcESMOb3ADNp1ETU0YM6d70s7Tq4Io1K5kZfqYeMku+XUg5wmOaUnJZ6jwYyzl\nOpY130TIswplVklmgC+5UFlweGtDqQQIrHP0/g7FAoGBANRAyuNn/zP8W51TbUqr\nExoUFB/gpdQItyXPMLm4fCs/sak3OQ5PARNkUfJf2PKhY86WBHh241crSseMDMxB\nQfPDqEDNCIZu+r+mnKeMQB/7YkC9+1kBbEtCSQal9F1KXUhQevVGeE68399HwgoG\nKV+9EoWLiD5LRoO1rJx6/TjX\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-9heh5@jazzee-9b074.iam.gserviceaccount.com",
          "client_id": "116998828798790816711",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-9heh5%40jazzee-9b074.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        scopes);
    final accessToken = await client.credentials.accessToken.data;
    return accessToken;
  }
}
