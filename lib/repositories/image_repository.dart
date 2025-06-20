import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> uploadImage(File imageFile, int? recipeId) async {
  final uri = Uri.parse('http://10.0.2.2:8080/api/v1/images/upload' +
      (recipeId != null ? '?recipeId=$recipeId' : ''));
  final request = http.MultipartRequest('POST', uri)
    ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));
  final response = await request.send();

  if (response.statusCode == 200) {
    final respStr = await response.stream.bytesToString();
    final data = jsonDecode(respStr);
    return data['downloadUrl'];
  }
  return null;
}
