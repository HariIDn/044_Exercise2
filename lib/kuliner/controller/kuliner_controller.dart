import 'dart:convert';
import 'dart:io';

import '../model/kuliner.dart';
import '../service/kuliner_service.dart';

class KulinerController {
  final kulinerservice = KulinerService();

  Future<Map<String, dynamic>> addCulinary(Kuliner culinary, File? file) async {
    Map<String, String> data = {
      'nama': culinary.nama_tempat,
      'kuliner': culinary.kuliner,
      'alamat': culinary.alamat,
    };
    try {
      var response = await kulinerservice.addCulinary(data, file);

      if (response.statusCode == 201) {
        return {'success': true, 'message': 'Data berhasil disimpan,'};
      } else {
        if (response.headers['content-type']!.contains('application/json')) {
          var decodeJson = jsonDecode(response.body);
          return {
            'success': false,
            'message': decodeJson['message'] ?? 'Terjadi Kesalahan',
          };
        }
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi Kesalahan: $e',
      };
    }
    return await addCulinary(culinary, file);
  }

  Future<List<Kuliner>> getPlace() async {
    try {
      List<dynamic> placeData = await kulinerservice.fetchCulinary();
      List<Kuliner> place =
          placeData.map((json) => Kuliner.fromMap(json)).toList();
      return place;
    } catch (e) {
      print(e);
      throw Exception("Gagal mengambil data");
    }
  }

  Future<Map<String, dynamic>> editKuliner(
      Kuliner kuliner, File? file, String id) async {
    Map<String, String> data = {
      'nama_tempat': kuliner.nama_tempat,
      'alamat': kuliner.alamat,
    };

    try {
      var response = await kulinerservice.editCulinary(data, file, id);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Data berhasil diubah',
        };
      } else {
        if (response.headers['content-type']!.contains('application/json')) {
          var decodedJson = jsonDecode(response.body);
          return {
            'success': false,
            'message': decodedJson['message'] ?? 'Terjadi Kesalahan',
          };
        }

        var decodedJson = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              decodedJson['message'] ?? 'Terjadi Kesalahan saat mengubah data',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  Future<Map<String, dynamic>> deleteKuliner(String id) async {
    try {
      var response = await kulinerservice.deleteCulinary(id);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Data berhasil dihapus',
        };
      } else {
        if (response.headers['content-type']!.contains('application/json')) {
          var decodedJson = jsonDecode(response.body);
          return {
            'success': false,
            'message': decodedJson['message'] ?? 'Terjadi Kesalahan',
          };
        }

        var decodedJson = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              decodedJson['message'] ?? 'Terjadi Kesalahan saat menghapus data',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }
}
