import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


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

  Future<List<File>> urlsToFiles (String draftID, List<String> imgUrls) async {
    List<File> imgFiles = [];
    for (int i = 0; i < imgUrls.length; i++) {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      File file = File(tempPath + (i).toString() + '_' + draftID);

      http.Response response = await http.get(Uri.parse(imgUrls[i]));
      await file.writeAsBytes(response.bodyBytes);
      imgFiles.add(file);
    }
    return imgFiles;
  }
}