class UserModel {
final int id;
final String name;
final String userName;
final String email;

UserModel({
required this.id,
required this.name,
required this.userName,
required this.email,
});

factory UserModel.fromJson(Map<String, dynamic> json) {
return UserModel(
id: json['id'] ?? 0,
name: json['name'] ?? '',
userName: json['username'] ?? '', 
email: json['email'] ?? '',
);
}
}