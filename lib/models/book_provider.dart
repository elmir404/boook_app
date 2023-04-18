// import 'package:ebook/models/book_model.dart';
// import 'package:sqflite/sqflite.dart';

// class BookProvider {
//   String _bDataName = "bookDatabase";
//   String _bTableName = "book";

//   int _version = 1;
//   late Database database;
//   String columnName = "Title";
//   String colDesc = "Text";
//   String colId = "id";
//   Future<void> open() async {
//     database = await openDatabase(_bDataName, version: _version,
//         onCreate: ((db, version) {
//       db.execute(
//         '''CREATE TABLE $_bTableName ($colId INTEGER KEY AUTOINCREMENT,$columnName VARCHAR(100),$colDesc TEXT''');
//     }));
//   }

//   Future<List<BookModel>?> getList() async {
//     List<Map> bookMaps = await database.query(_bTableName);
//     return bookMaps.map((e) => BookModel.fromJson(e)).toList();
//   }

//   Future<BookModel>? getItem(int id) async {
//     final bookMaps = await database
//         .query('book', where: 'id=?', columns: ['id'], whereArgs: [id]);
//     if (bookMaps.isNotEmpty)
//       return BookModel.fromJson(bookMaps.first);
//     else
//       return null;
//   }

//   Future<void> close() async {
//     await database.close();
//   }
// }
