import 'package:assignment/api/api_service.dart';
import 'package:assignment/exceptions/app_exceptions.dart';
import 'package:assignment/models/app_data.dart';
import 'package:assignment/models/post_model.dart';
import 'package:assignment/models/user_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var posts = <PostModel>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() async {
    isLoading.value = true;
    try {
      final data = await ApiService.fetchPosts();
      posts.assignAll(data);
      AppData.instance.posts = data;
    } catch (e) {
      Get.snackbar('Error', e is AppException ? e.message : 'Fail');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addPosts(String title, String body) async {
    try {
      final newPost = await ApiService.createPost(title, body);
      posts.insert(0, newPost);
      
    } catch (e) {
      Get.snackbar('Error','hi');
    }
  }
}

class UserController extends GetxController {
var users = <UserModel>[].obs;
var isLoading = false.obs;

@override
void onInit() {
super.onInit();
fetchAllUsers();
}

void fetchAllUsers() async {
isLoading.value = true;
try {
final data = await ApiService.fetchAllUsers();
users.assignAll(data);
} catch (e) {
Get.snackbar('Error', e is AppException ? e.message : 'Failed to load users');
} finally {
isLoading.value = false;
}
}
}