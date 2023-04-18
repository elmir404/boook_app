// To parse this JSON data, do
//
//     final paragraphModel = paragraphModelFromJson(jsonString);

import 'dart:convert';

ParagraphModel paragraphModelFromJson(String str) =>
    ParagraphModel.fromJson(json.decode(str));

String paragraphModelToJson(ParagraphModel data) => json.encode(data.toJson());

class ParagraphModel {
  ParagraphModel({
    required this.id,
    required this.description,
    this.paragraphFiles,
    required this.isActive,
  });

  int id;
  String description;
  List<ParagraphFile>? paragraphFiles;
  bool isActive;

  factory ParagraphModel.fromJson(Map<String, dynamic> json) => ParagraphModel(
        id: json["id"],
        description: json["description"],
        paragraphFiles: json["paragraphFiles"] == null
            ? []
            : List<ParagraphFile>.from(
                json["paragraphFiles"]?.map((x) => ParagraphFile.fromJson(x))),
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "paragraphFiles":
            List<dynamic>.from(paragraphFiles!.map((x) => x.toJson())),
        "isActive": isActive,
      };
}

class ParagraphFile {
  ParagraphFile({
    this.id,
    this.fileName,
    this.path,
  });

  int? id;
  String? fileName;
  String? path;

  factory ParagraphFile.fromJson(Map<String, dynamic> json) => ParagraphFile(
        id: json["id"],
        fileName: json["fileName"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fileName": fileName,
        "path": path,
      };
}
