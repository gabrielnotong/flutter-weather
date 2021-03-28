import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class NetworkHelper {
  String url;

  NetworkHelper({this.url});

  Future getData() async {
    Uri u = Uri.parse(url);

    http.Response response = await http.get(u);

    var data;
    if (response.statusCode == HttpStatus.ok) {
      data = jsonDecode(response.body);
    }

    return data;
  }
}
