class Blog {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> selectedTopics;
  final DateTime updatedAt;

  const Blog({
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.selectedTopics,
    required this.updatedAt,
  });

  static final List<String> topics = [
    'Technology',
    'Business',
    'Programming',
    'Entertainment',
  ];
}
