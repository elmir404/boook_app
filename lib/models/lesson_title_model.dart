// import 'package:ebook/models/lesson_model.dart';

// class LessontTitleModel {
//   int? id;
//   String? name;
//   List<LessonModel>? children;

//   LessontTitleModel({this.id, this.name, this.children});

//   LessontTitleModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     if (json['children'] != null) {
//       children = <LessonModel>[];
//       json['children'].forEach((v) {
//         children!.add(new LessonModel.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     if (this.children != null) {
//       data['children'] = this.children!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Children {
//   int? id;
//   String? name;
//   List<LessonModel>? child;

//   Children({this.id, this.name, this.child});

//   Children.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     if (json['child'] != null) {
//       child = <LessonModel>[];
//       json['child'].forEach((v) {
//         child!.add(new LessonModel.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     if (this.child != null) {
//       data['child'] = this.child!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
