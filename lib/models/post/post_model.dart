class Post {
  Post({
    required this.postId,
    required this.postBy,
    required this.postDate,
    required this.postDes,
    required this.postImage,
    required this.postByName,
    required this.collageName,
    required this.like,
  });

  final String postId;
  final String postBy;
  final String postDate;
  final String postDes;
  final String postImage;
  final String postByName;
  final String collageName;
  final String like;

  Post.fromMap(Map<String, dynamic> map)
      : postId = map['post_id'] ?? '',
        postBy = map['post_by'] ?? '',
        postDate = map['created_at'] ?? '',
        postDes = map['post_des'] ?? '',
        postImage = map['image'] ?? '',
        postByName = map['post_by_name'] ?? '',
        collageName = map['collage_name'] ?? '',
        like = map['likes'] ?? '';
}
