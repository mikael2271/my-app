import 'package:http/http.dart' as http;

class WebService {
  WebService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  static const _baseUrl =
      'example.pt'; // foi removido 'https://' porque dava erro

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<http.Response> post(
      {required String obj, required String endpoint, String? token}) async {
    final request = Uri.https(_baseUrl, endpoint);
    if (token != null) {
      requestHeaders.addAll({'Authorization': 'Bearer $token'});
    }
    return await _httpClient.post(request, headers: requestHeaders, body: obj);
  }

  Future<http.Response> get(
      {required String endpoint,
      String? token,
      Map<String, dynamic>? queryParameters}) async {
    final request = Uri.https(_baseUrl, endpoint, queryParameters);
    if (token != null) {
      requestHeaders.addAll({'Authorization': 'Bearer $token'});
    }
    return await _httpClient.get(request, headers: requestHeaders);
  }

  Future<http.Response> put(
      {required String obj, required String endpoint, String? token}) async {
    final request = Uri.https(_baseUrl, endpoint);
    if (token != null) {
      requestHeaders.addAll({'Authorization': 'Bearer $token'});
    }
    return await _httpClient.put(request, headers: requestHeaders, body: obj);
  }
}
