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

  Future<List<Photo>> fetchPhotos() async {
    try {
      final response = await _dio
          .get('https://jsonplaceholder.typicode.com/albums/1/photos');
      logger.d(response);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = response.data;
        logger.d(jsonResponse);
        return jsonResponse.map((photo) => Photo.fromJson(photo)).toList();
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      throw Exception('Failed to load photos: ${e.toString()}');
    }
  }
}

class JsonPlaceholderApi {
  JsonPlaceholderApi([Dio? dio])
      : _dio = dio ??
      Dio(BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      ));

  final Dio _dio;

  // ─────────────────────────────── GET ───────────────────────────────

  /// GET /posts
  Future<Response<List<dynamic>>> fetchPosts() =>
      _dio.get<List<dynamic>>('/posts');

  /// GET /posts/1
  Future<Response<Map<String, dynamic>>> fetchPost(int id) =>
      _dio.get<Map<String, dynamic>>('/posts/$id');

  /// GET /posts/1/comments
  Future<Response<List<dynamic>>> fetchPostComments(int postId) =>
      _dio.get<List<dynamic>>('/posts/$postId/comments');

  /// GET /comments?postId=1
  Future<Response<List<dynamic>>> fetchCommentsByQuery(int postId) =>
      _dio.get<List<dynamic>>(
        '/comments',
        queryParameters: {'postId': postId},
      );

  // ─────────────────────────────── POST ──────────────────────────────

  /// POST /posts
  Future<Response<Map<String, dynamic>>> createPost({
    required String title,
    required String body,
    required int userId,
  }) =>
      _dio.post<Map<String, dynamic>>(
        '/posts',
        data: {'title': title, 'body': body, 'userId': userId},
      );

  // ─────────────────────────────── PUT ───────────────────────────────

  /// PUT /posts/1  (full replace)
  Future<Response<Map<String, dynamic>>> updatePostPut(
      int id, {
        required String title,
        required String body,
        required int userId,
      }) =>
      _dio.put<Map<String, dynamic>>(
        '/posts/$id',
        data: {'title': title, 'body': body, 'userId': userId},
      );

  // ─────────────────────────────── PATCH ─────────────────────────────

  /// PATCH /posts/1  (partial update)
  Future<Response<Map<String, dynamic>>> updatePostPatch(
      int id, {
        String? title,
        String? body,
        int? userId,
      }) =>
      _dio.patch<Map<String, dynamic>>(
        '/posts/$id',
        data: {
          if (title != null) 'title': title,
          if (body != null) 'body': body,
          if (userId != null) 'userId': userId,
        },
      );

  // ─────────────────────────────── DELETE ────────────────────────────

  /// DELETE /posts/1
  Future<Response<void>> deletePost(int id) => _dio.delete<void>('/posts/$id');
}
/// Quick smoke‑test for JsonPlaceholderApi

Future<void> runJsonPlaceholderDemo() async {
  final api = JsonPlaceholderApi();
  try {
    // 1️⃣ GET /posts
    final postsRes = await api.fetchPosts();
    logger.d('Fetched ${postsRes.data?.length ?? 0} posts 📰');

    // 2️⃣ POST /posts
    final newPostRes = await api.createPost(
      title: 'Dio is awesome 🚀',
      body: 'And so is Flutter!',
      userId: 1,
    );
    final newId = newPostRes.data?['id'] as int?;
    logger.d('Created post with id $newId');

    if (newId == null) return; // Stop if creation failed

    // 3️⃣ PATCH /posts/{id}
    await api.updatePostPatch(newId, title: 'Updated title ✏️');
    logger.d('Patched post $newId');

    // 4️⃣ DELETE /posts/{id}
    await api.deletePost(newId);
    logger.d('Deleted post $newId 🪦');
  } catch (e, s) {
    logger.d('Error: $e\n$s');
  }
}

