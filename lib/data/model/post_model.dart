class PostModel {
  final String name;
  final String imageUrl;
  final String content;
  final List<String> comments;
  final int likes;

  PostModel({
    required this.name,
    required this.imageUrl,
    required this.content,
    required this.comments,
    required this.likes,
  });
}

List<PostModel> dataDummy = [
  PostModel(
    name: 'Karina',
    imageUrl: 'https://wallpapercave.com/wp/wp8315545.jpg',
    content: 'Armagedon',
    comments: List.empty(),
    likes: 100,
  ),
  PostModel(
    name: 'Karina',
    imageUrl: 'https://wallpapercave.com/wp/wp8315545.jpg',
    content: 'Armagedon',
    comments: List.empty(),
    likes: 100,
  ),
  PostModel(
    name: 'Karina',
    imageUrl: 'https://wallpapercave.com/wp/wp8315545.jpg',
    content: 'Armagedon',
    comments: List.empty(),
    likes: 100,
  ),
  PostModel(
    name: 'Karina',
    imageUrl: 'https://wallpapercave.com/wp/wp8315545.jpg',
    content: 'Armagedon',
    comments: List.empty(),
    likes: 100,
  ),
  PostModel(
    name: 'Karina',
    imageUrl: 'https://wallpapercave.com/wp/wp8315545.jpg',
    content: 'Armagedon',
    comments: List.empty(),
    likes: 100,
  ),
];
