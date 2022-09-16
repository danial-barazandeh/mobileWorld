// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.id,
    this.title,
    this.image,
    this.content,
  });

  int id;
  dynamic title;
  dynamic image;
  dynamic content;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    title: json["title"].toString(),
    image: json["image"].toString(),
    content: json["content"].toString()
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "content": content
  };
}
