import 'package:dio/dio.dart';

class ApiService {
  var dio = Dio();

  Future fetchPosts() async {
    var response = await dio.get("https://jsonplaceholder.typicode.com/posts");
    return response;
  }

  Future fetchComments() async {
    var response =
        await dio.get("https://jsonplaceholder.typicode.com/comments");
    return response;
  }
}
