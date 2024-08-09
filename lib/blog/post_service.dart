import 'package:techcity/blog/client.dart';
import 'package:techcity/blog/post.dart';

class PostService {
  final _apiClient = ApiClient();

  Future<PostResponse> getAllPost() async {
    final response =
        await _apiClient.getData(endPoint: 'https://dummyjson.com/posts');
    return PostResponse.fromJson(response);
  }
}
