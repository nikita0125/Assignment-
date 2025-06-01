class PostModel {
final int userId;
final int id;
final String title;
final String body;

PostModel({
required this.userId,
required this.id,
required this.title,
required this.body,
});

factory PostModel.fromJson(Map<String, dynamic> json) {
return PostModel(
userId: json['userId'] ?? 0,
id: json['id'] ?? 0,
title: json['title'] ?? '',
body: json['body'] ?? '',
);
}
}