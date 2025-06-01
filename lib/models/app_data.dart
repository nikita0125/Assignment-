import 'package:assignment/models/comment_model.dart';
import 'package:assignment/models/post_model.dart';
import 'package:assignment/models/user_model.dart';

class AppData {
  AppData._privateConstructor();
  static final AppData instance = AppData._privateConstructor();

  List<PostModel> posts = [];
  Map<int, List<CommentModel>> postComments = {};
  Map<int, UserModel> users = {};
}

