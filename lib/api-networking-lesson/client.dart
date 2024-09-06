import 'package:http/http.dart' as http;

class ApiClient {
  Future<dynamic> postData({required String endPoint, dynamic data, required Map<String, dynamic> headers}) async{
    return await http.post(Uri.parse(endPoint), body: data);
  }

  Future<dynamic> getData({required String endPoint}) async{
    return await http.get(Uri.parse(endPoint));
  }

  Future<dynamic> updateData({required String endPoint,required  Map<String, dynamic> data}) async{
    return await http.put(Uri.parse(endPoint), body: data);
  }
}
