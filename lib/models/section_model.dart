import 'dart:convert';

ChapterModel chapterModelFromJson(String str) =>
    ChapterModel.fromJson(json.decode(str));

String chapterModelToJson(ChapterModel data) => json.encode(data.toJson());

class ChapterModel {
  ChapterModel({
    required this.id,
    required this.name,
    required this.topics,
    required this.isActive,
  });

  int id;
  String name;
  List<Topic> topics;
  bool isActive;

  factory ChapterModel.fromJson(Map<String, dynamic> json) => ChapterModel(
        id: json["id"],
        name: json["name"],
        topics:
            List<Topic>.from(json["topicTitles"].map((x) => Topic.fromJson(x))),
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "topicTitles": List<dynamic>.from(topics.map((x) => x.toJson())),
        "isActive": isActive,
      };
}

class Topic {
  Topic({
    this.id,
    this.name,
    this.description,
    this.topics,
    this.isActive,
    this.paragraphs,
  });

  int? id;
  String? name;
  String? description;
  List<Topic>? topics;
  bool? isActive;
  List<dynamic>? paragraphs;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        topics: json["topics"] == null
            ? []
            : List<Topic>.from(json["topics"].map((x) => Topic.fromJson(x))),
        isActive: json["isActive"],
        paragraphs: json["paragraphs"] == null
            ? null
            : List<dynamic>.from(json["paragraphs"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "topics": topics == null
            ? []
            : List<dynamic>.from(topics!.map((x) => x.toJson())),
        "isActive": isActive,
        "paragraphs": paragraphs == null
            ? null
            : List<dynamic>.from(paragraphs!.map((x) => x)),
      };
}
