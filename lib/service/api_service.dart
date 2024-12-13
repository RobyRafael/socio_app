import 'dart:async';
import 'package:dio/dio.dart';
import 'package:socio_app/entity/post_entity.dart';
import 'package:socio_app/entity/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://sosiov2.efrosine.my.id/api',
    headers: {'Accept': 'application/json'},
  ));
  final SharedPreferencesAsync pref = SharedPreferencesAsync();

  ApiService();

  Future<String?> getRole() async {
    return pref.getString('role');
  }

  Future<String> login(String email, String password) async {
    try {
      final response = await _dio
          .post('/login', data: {"email": email, "password": password});
      String token = response.data['token'];
      int id = response.data['user']['id'];
      await pref.setString('token', token);
      await pref.setInt('id', id);
      return 'login berhasil';
    } on DioException catch (e) {
      return Future.error(
          Exception(e.response?.data['message'] ?? 'message error nulll'));
    }
  }

  Future<String> register(String username, String email, String password,
      String bio, String profilePicture) async {
    try {
      final response = await _dio.post('/register', data: {
        "username": username,
        "email": email,
        "password": password,
        "bio": bio,
        "profile_picture": profilePicture
      });
      return 'proses register berhasil';
    } on DioException catch (e) {
      return Future.error(
          Exception(e.response?.data['message'] ?? 'message error nullll'));
    }
  }

  Future<PostEntity> getPostById(int postId) async {
    try {
      final response = await _dio.get('/posts/$postId');
      var data = response.data;
      return PostEntity.fromJson(data);
    } on DioException catch (e) {
      return Future.error(
          Exception('Failed to load post: ${e.response?.data['message']}'));
    }
  }

  Future<List<PostEntity>> getAllPosts() async {
    try {
      String? token = await pref.getString('token');
      final response = await _dio.get(
        '/posts',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => PostEntity.fromJson(json)).toList();
    } on DioException catch (e) {
      return Future.error(
          Exception('Failed to load posts: ${e.response?.data['message']}'));
    }
  }

  Future<List<PostEntity>> getCurrentUserPosts() async {
    try {
      String? token = await pref.getString('token');
      int? id = await pref.getInt('id');

      final response = await _dio.get(
        '/users/${id ?? 1}/posts',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => PostEntity.fromJson(json)).toList();
    } on DioException catch (e) {
      return Future.error(
          Exception('Failed to load posts: ${e.response?.data['message']}'));
    }
  }

  Future<String> createPost(String content, String image) async {
    try {
      String? token = await pref.getString('token');
      final response = await _dio.post('/posts',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: {"content": content, "image": image});
      return 'berhasil membuat feed';
    } on DioException catch (e) {
      return Future.error(
          Exception('Failed to create post: ${e.response?.data['message']}'));
    }
  }

  Future<String> updatePost(String content, String image, int id) async {
    try {
      String? token = await pref.getString('token');
      final response = await _dio.put('/posts/$id',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: {"content": content, "image": image});
      return 'berhasil update feed';
    } on DioException catch (e) {
      return Future.error(
          Exception('Failed to update post: ${e.response?.data['message']}'));
    }
  }

  Future<String> deletePost(int postId) async {
    try {
      String? token = await pref.getString('token');
      final response = await _dio.delete('/posts/$postId',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return response.data['message'] ?? 'message null';
    } on DioException catch (e) {
      return Future.error(
          Exception('Failed to delete post: ${e.response?.data['message']}'));
    }
  }

  Future<String> addComment(int postId, String comment) async {
    try {
      String? token = await pref.getString('token');
      final response = await _dio.post('/posts/$postId/comments',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: {"comment": comment});
      return response.data['message'] ?? 'message null';
    } on DioException catch (e) {
      return Future.error(
          Exception('Failed to add comment: ${e.response?.data['message']}'));
    }
  }

  Future<String> likePost(int postId) async {
    try {
      String? token = await pref.getString('token');
      final response = await _dio.post('/posts/$postId/like',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return response.data['message'] ?? 'message null';
    } on DioException catch (e) {
      return Future.error(
          Exception('Failed to like post: ${e.response?.data['message']}'));
    }
  }

  Future<String> unlikePost(int postId) async {
    try {
      String? token = await pref.getString('token');
      final response = await _dio.delete('/posts/$postId/unlike',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return response.data['message'] ?? 'message null';
    } on DioException catch (e) {
      return Future.error(
          Exception('Failed to unlike post: ${e.response?.data['message']}'));
    }
  }

  Future<List<UserEntity>> searchUser(String username) async {
    try {
      final response = await _dio
          .get('/users/search', queryParameters: {'username': username});
      List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => UserEntity.fromJson(json)).toList();
    } on DioException catch (e) {
      return Future.error(
          Exception('Failed to search user: ${e.response?.data['message']}'));
    }
  }

  Future<UserEntity> getUserProfile(int userId) async {
    try {
      final response = await _dio.get('/users/$userId');
      var data = response.data;
      return UserEntity.fromJson(data);
    } on DioException catch (e) {
      return Future.error(Exception(
          'Failed to load user profile: ${e.response?.data['message']}'));
    }
  }

  Future<UserEntity> getCurrentUser() async {
    try {
      String? token = await pref.getString('token');
      final response = await _dio.get('/me',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      var data = response.data;
      return UserEntity.fromJson(data);
    } on DioException catch (e) {
      return Future.error(Exception(
          'Failed to load user profile: ${e.response?.data['message']}'));
    }
  }

  Future<String> followUser(int userId) async {
    try {
      String? token = await pref.getString('token');
      final response = await _dio.post('/users/$userId/follow',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return response.data['message'] ?? 'message null';
    } on DioException catch (e) {
      return Future.error(
          Exception('Failed to follow user: ${e.response?.data['message']}'));
    }
  }

  Future<String> unfollowUser(int userId) async {
    try {
      String? token = await pref.getString('token');
      final response = await _dio.delete('/users/$userId/unfollow',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return response.data['message'] ?? 'message null';
    } on DioException catch (e) {
      return Future.error(
          Exception('Failed to unfollow user: ${e.response?.data['message']}'));
    }
  }

  Future<List<UserEntity>> getFollowers(int userId) async {
    try {
      final response = await _dio.get('/users/$userId/followers');
      List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => UserEntity.fromJson(json)).toList();
    } on DioException catch (e) {
      return Future.error(Exception(
          'Failed to load followers: ${e.response?.data['message']}'));
    }
  }

  Future<List<UserEntity>> getFollowing(int userId) async {
    try {
      final response = await _dio.get('/users/$userId/following');
      List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => UserEntity.fromJson(json)).toList();
    } on DioException catch (e) {
      return Future.error(Exception(
          'Failed to load following: ${e.response?.data['message']}'));
    }
  }

  Future<String> testConnection() async {
    try {
      final response = await _dio.get('/api');
      return response.data['message'] ?? 'Connection successful';
    } on DioException catch (e) {
      return Future.error(
          Exception('Connection failed: ${e.response?.data['message']}'));
    }
  }
}
