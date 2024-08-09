import 'package:http/http.dart' as http;

class ApiClient {
  Future<dynamic> postData({required String endPoint, dynamic data, required Map<String, dynamic> headers}) {
    return http.post(Uri.parse(endPoint), body: data);
  }

  Future<dynamic> getData({required String endPoint}) {
    return http.get(Uri.parse(endPoint));
  }
}
