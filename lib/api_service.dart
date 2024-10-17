import 'package:dio/dio.dart';
import 'package:json_placeholder_rest_dio/components.dart';

import 'models.dart';

class ApiService {
  var _dio = Dio();

  Future<List<Post>> fetchPosts() async {
    try {
      Response response =
          await _dio.get('https://jsonplaceholder.typicode.com/posts');
      // Converting the response data (JSON) into a list of Post objects
      List<Post> posts =
          (response.data as List).map((json) => Post.fromJson(json)).toList();
      return posts;
    } catch (e) {
      print('Error fetching posts: $e');
      throw Exception('Failed to load posts');
    }
  }

  Future<List<Comment>> fetchComments() async {
    try {
      Response response =
          await _dio.get('https://jsonplaceholder.typicode.com/comments');
      // Converting the response data (JSON) into a list of Post objects
      List<Comment> comment = (response.data as List)
          .map((json) => Comment.fromJson(json))
          .toList();
      return comment;
    } catch (e) {
      logger.d('Error fetching posts: $e');
      throw Exception('Failed to load posts');
    }
  }
}
