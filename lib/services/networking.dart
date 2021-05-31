import 'package:http/http.dart' as http;
import 'dart:convert';

var decodedData;
class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

   Future<dynamic> getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
