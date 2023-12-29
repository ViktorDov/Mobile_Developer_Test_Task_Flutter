import 'dart:convert';
import 'dart:io';

class ApiClient {
  final _client = HttpClient();

  Future<void> postMessage(
      {required String name,
      required String email,
      required String message}) async {
    final url = Uri.parse('https://api.byteplex.info/api/test/contact/');
    final request = await _client.postUrl(url);

    final body = {
      'name': name,
      'email': email,
      'message': message,
    };

    request.headers.set('Content-Type', 'application/json');
    request.write(jsonEncode(body));
    final response = await request.close();

    if (response.statusCode != 201) {
      throw Exception('Error ${response.statusCode}');
    } else {
      print('created: ${response.statusCode}');
    }
  }
}
