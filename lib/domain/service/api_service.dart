import 'package:flutter_test_message/domain/api/api_client.dart';
import 'package:flutter_test_message/domain/entity/message.dart';

class ApiService {
  final _apiClient = ApiClient();

  Future<void> postMessage({required Message message}) async {
    final response = await _apiClient.postMessage(
        name: message.name, email: message.email, message: message.message);
    return response;
  }
}
