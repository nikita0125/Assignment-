class CommentModel {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  CommentModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });
  factory CommentModel.fromJson(Map<String, dynamic> json) {
return CommentModel(
postId: json['postId'] ?? 0,
id: json['id'] ?? 0,
name: json['name'] ?? '',
email: json['email'] ?? '',
body: json['body'] ?? '',
);
}
}
