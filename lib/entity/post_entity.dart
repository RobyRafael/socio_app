import 'package:socio_app/entity/comment_entity.dart';
import 'package:socio_app/entity/like_entity.dart';
import 'package:socio_app/entity/user_entity.dart';

class PostEntity {
  final int? id;
  final String? content;
  final String? image;
  final int? userId;
  final DateTime? createdAt;
  final int? comment_count;
  final int? like_count;
  final UserEntity? user;
  final List<CommentEntity>? comments;
  final List<LikeEntity>? likes;

  PostEntity({
    this.id,
    this.content,
    this.image,
    this.userId,
    this.createdAt,
    this.comment_count,
    this.like_count,
    this.user,
    this.comments,
    this.likes,
  });

  // Mengonversi JSON ke objek PostEntity
  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
      id: json['id'],
      content: json['content'],
      image: json['image'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      comment_count: json['comment_count'],
      like_count: json['like_count'],
      user: json['user'] != null ? UserEntity.fromJson(json['user']) : null,
      comments: json['comments'] != null
          ? List<CommentEntity>.from(
              json['comments'].map((x) => CommentEntity.fromJson(x)))
          : null,
      likes: json['likes'] != null
          ? List<LikeEntity>.from(
              json['likes'].map((x) => LikeEntity.fromJson(x)))
          : null,
    );
  }

  // Mengonversi objek PostEntity ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'image': image,
      'user_id': userId,
      'created_at': createdAt?.toIso8601String() ?? '2021-12-12',
      'comment_count': comment_count,
      'like_count': like_count,
      'user': user?.toJson(),
      'comments': comments?.map((x) => x.toJson()).toList(),
      'likes': likes?.map((x) => x.toJson()).toList()
    };
  }
}
