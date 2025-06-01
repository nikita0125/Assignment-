import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';
import '../api/api_service.dart';
import '../screens/user_profile_screen.dart';
import '../exceptions/app_exceptions.dart';

class PostDetailsScreen extends StatefulWidget {
final PostModel post;
const PostDetailsScreen({super.key, required this.post});

@override
State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
final RxList<CommentModel> comments = <CommentModel>[].obs;
final RxBool isLoading = false.obs;

@override
void initState() {
super.initState();
fetchComments();
}

Future<void> fetchComments() async {
isLoading(true);
try {
final data = await ApiService.fetchComments(widget.post.id);
comments.assignAll(data);
} catch (e) {
Get.snackbar('Error', e is AppException ? e.message : 'Failed to load comments');
} finally {
isLoading(false);
}
}

@override
Widget build(BuildContext context) {
final post = widget.post;


return Scaffold(
  appBar: AppBar(
    title: const Text('Post Details'),
    actions: [
      IconButton(
        icon: const Icon(Icons.person),
        onPressed: () {
          Get.to(() => UserProfileScreen());
        },
      ),
    ],
  ),
  body: Obx(() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(post.body),
          const SizedBox(height: 20),
          const Text("Comments", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          if (isLoading.value)
            const Center(child: CircularProgressIndicator())
          else
            ...comments.map((comment) => Card(
                  child: ListTile(
                    title: Text(comment.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: [
                    
                    Text(comment.body),
                    SizedBox(height: 5,),
                                     Text('Email:${comment.email}',style: TextStyle(fontSize: 12),),
                    ],),
                  ),
                )),
        ],
      ),
    );
  }),
);
}
}