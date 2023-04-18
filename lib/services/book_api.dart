import 'dart:convert';

import 'package:boook_app/models/paragraph_model.dart';
import 'package:boook_app/models/section_model.dart';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BookApi {
  static const String _url = 'https://toogoo-001-site5.ftempurl.com';
  static Future<List<ParagraphModel>> getAllParagraphs() async {
    List<ParagraphModel> _list = [];
    var response = await Dio().get(_url + "/api/Paragraph/GetAllParagraphs");

    debugPrint(response.data.toString());
    if (response.statusCode == 200) {
      var paragraphs = response.data['data'] as List;
      debugPrint(paragraphs.toString());

      _list = paragraphs.map((e) => ParagraphModel.fromJson(e)).toList();
      return _list;
    } else {
      throw Exception('Failed to load courses');
    }
  }

  static Future<List<ParagraphModel>> searchParagraphs(String query) async {
    List<ParagraphModel> _list = [];
    var formData = FormData.fromMap({
      'Temp': query,
    });
    var response = await Dio().request(
        _url + "/api/Paragraph/SeacrhParagraph?currentPage=1&pageSize=100",
        data: formData,
        options: Options(method: "POST"));

    debugPrint("sdasdsad" + response.data['data'].toString());
    if (response.statusCode == 200) {
      var paragraphs = response.data['data']['value'] as List;
      debugPrint(paragraphs.toString());

      _list = paragraphs.map((e) => ParagraphModel.fromJson(e)).toList();
      return _list;
    } else {
      throw Exception('Failed to load courses');
    }
  }

  static Future<List<ParagraphModel>> getParagraphs(
      String? titleId, String? topicId, String? pageNum) async {
    List<ParagraphModel> _list = [];
    var formData = FormData.fromMap({
      'TopicTitleId': titleId,
      'TopicId': topicId,
    });
    var response = await Dio().request(
        _url +
            "/api/Paragraph/SeacrhParagraphById?currentPage=${pageNum}&pageSize=10",
        data: formData,
        options: Options(method: "POST"));

    debugPrint("sdasdsad" + response.data['data'].toString());
    if (response.statusCode == 200) {
      var paragraphs = response.data['data']['value'] as List;
      debugPrint(paragraphs.toString());

      paragraphs.map((e) => _list.add(ParagraphModel.fromJson(e))).toList();
      return _list;
    } else {
      throw Exception('Failed to load courses');
    }
  }

  static Future<List<ChapterModel>> getAllChapters() async {
    List<ChapterModel> _list = [];
    var response = await Dio().get(_url + "/api/Chapter/GetChapters");
    debugPrint(response.data.toString());
    if (response.statusCode == 200) {
      var chapter = response.data['data'] as List;
      debugPrint(chapter.toString());

      _list = chapter.map((e) => ChapterModel.fromJson(e)).toList();
      return _list;
    } else {
      throw Exception('Failed to load courses');
    }
  }

  static Future<List<ParagraphModel>> getAfterParagraphById(int id) async {
    try {
      List<ParagraphModel> _list = [];
      int idd = id - 1;
      var response =
          await Dio().get(_url + "/api/Paragraph/GetParagraph?id=${idd}");
      debugPrint(response.data['data'].toString());
      if (response.statusCode == 200) {
        if (response.data['data'] != null)
          _list.add(ParagraphModel.fromJson(response.data['data']));
        else {
          getAfterParagraphById(idd);
        }

        return _list;
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      return [];
    }
  }

  static Future<List<ParagraphModel>> getBeforeParagraphById(int id) async {
    try {
      List<ParagraphModel> _list = [];
      int idd = id + 1;
      var response =
          await Dio().get(_url + "/api/Paragraph/GetParagraph?id=${idd}");
      debugPrint(response.data['data'].toString());
      if (response.statusCode == 200) {
        if (response.data['data'] != null)
          _list.add(ParagraphModel.fromJson(response.data['data']));
        else {
          getAfterParagraphById(idd);
        }

        return _list;
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      return [];
    }
  }

  static Future<List<ChapterModel>> searchChapter(String query) async {
    List<ChapterModel> _list = [];
    var response = await Dio().request(
        _url + "/api/Chapter/CommonSearch?currentPage=1&pageSize=100",
        data: {"searchStr": query},
        options: Options(method: "POST"));

    debugPrint(response.data.toString());
    if (response.statusCode == 200) {
      var chapter = response.data['data']['value'] as List;
      debugPrint(chapter.toString());

      _list = chapter.map((e) => ChapterModel.fromJson(e)).toList();
      return _list;
    } else {
      throw Exception('Failed to load courses');
    }
  }
}
