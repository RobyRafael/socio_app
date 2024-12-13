class CommentEntity {
  final int? id;
  final String? comment;
  final String? username;

  CommentEntity({
    this.id,
    this.comment,
    this.username,
  });

  // Mengonversi JSON ke objek CommentEntity
  factory CommentEntity.fromJson(Map<String, dynamic> json) {
    return CommentEntity(
      id: json['id'],
      comment: json['comment'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'comment': comment,
        'username': username,
      };
}
