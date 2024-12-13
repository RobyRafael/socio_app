class LikeEntity {
  final int? id;
  final int? postId;
  final int? userId;

  LikeEntity({required this.id, required this.postId, required this.userId});

    LikeEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        postId = json['postId'],
        userId = json['userId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'postId': postId,
        'userId': userId,
      };

}