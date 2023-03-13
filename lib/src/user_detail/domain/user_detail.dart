class UserDetail {
  const UserDetail({
    required this.uid,
    required this.username,
    this.photoURL,
  });

  final String uid;
  final String username;
  final String? photoURL;

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      uid: json['uid'] as String,
      username: json['username'] as String,
      photoURL: json['photoURL'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'photoURL': photoURL,
    };
  }
}
