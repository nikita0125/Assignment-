import 'package:assignment/exceptions/app_exceptions.dart';
import 'package:assignment/models/comment_model.dart';
import 'package:assignment/models/post_model.dart';
import 'package:assignment/models/user_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com/'),
  );

  static Future<List<PostModel>> fetchPosts() async {
    try {
      final res = await _dio.get('/posts');
      if (res.statusCode == 200) {
        return (res.data as List).map((e) => PostModel.fromJson(e)).toList();
      } else {
        throw AppException('Failed to load posts. Status: ${res.statusCode}');
      }
    } catch (e) {
      throw _handleError(e);
    }
  }

  static Future<List<CommentModel>> fetchComments(int postId) async {
    try {
      final res = await _dio.get('/posts/$postId/comments');
      return (res.data as List).map((e) => CommentModel.fromJson(e)).toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  static Future<List<UserModel>> fetchAllUsers() async {
try {
final res = await _dio.get('/users');
if (res.statusCode == 200) {
return (res.data as List).map((e) => UserModel.fromJson(e)).toList();
} else {
throw AppException('Failed to load users. Status: ${res.statusCode}');
}
} catch (e) {
throw _handleError(e);
}
}

  static Future<PostModel> createPost(String title, String body) async {
    try {
      final res = await _dio.post(
        '/posts',
        data: {'title': title, 'body': body, 'userId': 1},
      );
      return PostModel.fromJson(res.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  static AppException _handleError(Object error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return TimeoutException();
      } else if (error.type == DioExceptionType.connectionError) {
        return NetworkException();
      }
    }
    return UnknownException();
  }
}
