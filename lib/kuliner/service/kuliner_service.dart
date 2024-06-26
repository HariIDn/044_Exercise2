import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class KulinerService {
  final String baseUrl = 'http://10.0.2.2/dbapi/';
  final String endpoint = 'db.php';

  Uri getUri(String path) {
    return Uri.parse("$baseUrl$path");
  }

  Future<http.Response> addCulinary(
      Map<String, String> data, File? file) async {
    var request = http.MultipartRequest(
      "POST",
      getUri(endpoint),
    )
      ..fields.addAll(data)
      ..headers['Content-Type'] = 'application/json';

    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('foto', file.path));
    } else {
      request.files.add(http.MultipartFile.fromString('foto', ''));
    }

    return await http.Response.fromStream(await request.send());
  }

  Future<List<dynamic>> fetchCulinary() async {
    var response = await http.get(
        getUri(
          endpoint,
        ),
        headers: {
          "Accept": "application/json",
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeResponse = json.decode(response.body);
      return decodeResponse['db.php'];
    } else {
      throw Exception('Failed to load culinary: ${response.reasonPhrase}');
    }
  }

  Future<http.Response> editCulinary(
      Map<String, String> data, File? file, String id) async {
    var request = http.MultipartRequest(
      'PUT',
      getUri('$endpoint/$id'),
    )
      ..fields.addAll(data)
      ..headers['Content-Type'] = 'multipart/form-data';

    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('foto', file.path));
    }

    return await http.Response.fromStream(await request.send());
  }

  Future<http.Response> deleteCulinary(String id) async {
    return await http.delete(getUri('$endpoint/$id'));
  }
}
