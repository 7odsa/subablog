import 'package:subablog/features/blog/domain/entities/blog.dart';

class BlogDm extends Blog {
  BlogDm({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.updatedAt,
    required super.imageUrl,
    required super.selectedTopics,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user_id': posterId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': selectedTopics,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogDm.fromJson(Map<String, dynamic> map) {
    return BlogDm(
      id: map['id'] as String,
      posterId: map['user_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
      imageUrl: map['image_url'] as String,
      selectedTopics: List<String>.from((map['topics'] ?? [])),
    );
  }
  Blog copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? selectedTopics,
    DateTime? updatedAt,
  }) {
    return Blog(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      selectedTopics: selectedTopics ?? this.selectedTopics,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
