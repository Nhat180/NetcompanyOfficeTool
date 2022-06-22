import 'dart:convert';
import 'package:http/http.dart' as http;


class HttpHandlerService {

  Future<bool> login (String name, String password) async {
    const String api = "https://netcompany-crawl-server.herokuapp.com/auth";
    // const String api = "http://10.0.2.2:8080/auth";
    final response = await http.post(Uri.parse(api),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': name,
          'password': password
        })
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> crawl (String name, String password) async {
    const String api = "https://netcompany-crawl-server.herokuapp.com/menu";
    final response = await http.post(Uri.parse(api),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': name,
        'password': password
      })
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}