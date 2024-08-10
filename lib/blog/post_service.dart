import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:techcity/blog/client.dart';
import 'package:techcity/blog/post.dart';

class PostService {
  final _apiClient = ApiClient();

  Future<PostResponse> getAllPosts() async {
    final response =
        await _apiClient.getData(endPoint: 'https://dummyjson.com/posts');
    print(response);
    return PostResponse.fromJson(jsonDecode(response.body));
  }
}

class PostProvider extends Model {
  List<Posts> _posts = [];
  bool _isLoading = false;

  bool get isBusy => _isLoading;
  final _postService = PostService();

  List<Posts> get posts => _posts;

  Future<void> fetchPosts() async {
    try {
      _isLoading = true;
      final postResponse = await _postService.getAllPosts();
      _isLoading = false;
      _posts = postResponse.posts ?? [];
      notifyListeners();
    } catch (e) {
      print(e.toString());
      _isLoading = false;
    }
  }
}
