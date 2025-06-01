import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../api/api_service.dart';
import '../exceptions/app_exceptions.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    isLoading(true);
    try {
      final data = await ApiService.fetchAllUsers();
      users.assignAll(data);
    } catch (e) {
      Get.snackbar(
        'Error',
        e is AppException ? e.message : 'Failed to load user',
      );
    } finally {
      isLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: Obx(() {
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: const Icon(Icons.person),
                title: Text(user.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '@${user.userName}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(user.email, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
