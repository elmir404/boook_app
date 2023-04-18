// To parse this JSON data, do
//
//     final topicModel = topicModelFromJson(jsonString);

import 'dart:convert';

TopicModel topicModelFromJson(String str) =>
    TopicModel.fromJson(json.decode(str));

String topicModelToJson(TopicModel data) => json.encode(data.toJson());

class TopicModel {
  TopicModel({
    this.id,
    this.name,
    this.description,
    this.paragraphs,
    this.topics,
    this.isActive,
  });

  int? id;
  String? name;
  String? description;
  List<dynamic>? paragraphs;
  List<TopicModel>? topics;
  bool? isActive;

  factory TopicModel.fromJson(Map<String, dynamic> json) => TopicModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        paragraphs: List<dynamic>.from(json["paragraphs"].map((x) => x)),
        topics: List<TopicModel>.from(json["topics"].map((x) => x)),
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "paragraphs": List<dynamic>.from(paragraphs!.map((x) => x)),
        "topics": List<dynamic>.from(topics!.map((x) => x)),
        "isActive": isActive,
      };
}
