class UserEntity {
  final int id;
  final String username;
  final String email;
  final String bio;
  final String profilePicture;
  final int? followersCount;
  final int? followingCount;
  final int? postsCount;

  UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.bio,
    required this.profilePicture,
    this.followersCount,
    this.followingCount,
    this.postsCount,
  });

  // Mengonversi JSON ke objek UserEntity
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      bio: json['bio'],
      profilePicture: json['profile_picture'],
      followersCount: json['followers_count'],
      followingCount: json['following_count'],
      postsCount: json['posts_count'],
    );
  }

  // Mengonversi objek UserEntity ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'bio': bio,
      'profile_picture': profilePicture,
    };
  }
}
