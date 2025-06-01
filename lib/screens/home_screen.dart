import 'package:assignment/controller/data_controller.dart';
import 'package:assignment/screens/post_details_screen.dart';
import 'package:assignment/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleControler = TextEditingController();
  final bodycontroller = TextEditingController();

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 130, 188, 227),
        title: Text(
          'Post what Matters!',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 29),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => const UserProfileScreen()),
            icon: const CircleAvatar(child: Icon(Icons.person)),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const CircularProgressIndicator();
        }
        return ListView.builder(
          itemCount: controller.posts.length,

          itemBuilder: (context, index) {
            final post = controller.posts[index];
            return Card(
              child: ListTile(
                title: Text(
                  post.title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                subtitle: Text(post.body),
                onTap: () => Get.to(() => PostDetailsScreen(post: post)),
              ),
            );
          },
        );
      }),
    );
  }
}
