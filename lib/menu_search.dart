import 'package:boook_app/book_read_page.dart';
import 'package:boook_app/models/section_model.dart';
import 'package:boook_app/services/book_api.dart';

import 'package:flutter/material.dart';

class MainMenuSearch extends StatefulWidget {
  const MainMenuSearch({super.key});

  @override
  State<MainMenuSearch> createState() => _MainMenuSearchState();
}

class _MainMenuSearchState extends State<MainMenuSearch> {
  late Future<List<ChapterModel>> _chapterListFuture;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _chapterListFuture = BookApi.getAllChapters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        appBar: AppBar(
            backgroundColor: Colors.teal.shade200,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            title: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: TextField(
                    style: TextStyle(fontSize: 25.0),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      // suffixIcon: IconButton(
                      //   icon: const Icon(Icons.clear),
                      //   onPressed: () {},
                      // ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _chapterListFuture = BookApi.searchChapter(val);
                      });
                    },
                  ),
                ))),
        body: FutureBuilder(
          future: _chapterListFuture,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              List<ChapterModel> _cList = snapshot.data!;

              return ListView.builder(
                itemCount: _cList.length,
                itemBuilder: (context, int index) {
                  return buildTopic(_cList[index]);
                },
              );
            } else if (snapshot.hasError) {
              return Center();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ));
  }

  Widget buildTopic(dynamic title) {
    bool tit = title?.topics?.isEmpty ?? true;
    List<Topic> list = title?.topics;
    if (list!.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.cyan.shade100,
          border: Border.all(
            color: Colors.cyan.shade200,
            width: 2,
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 8),
          title: Text(title.name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReadPage()),
            );
          },
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.teal.shade100,
        border: Border.all(
          color: Colors.teal.shade200,
          width: 2,
        ),
      ),
      child: ExpansionTile(
        title: Text(title.name),
        children: list.map((title) => buildTopic1(title)).toList(),
      ),
    );
  }

  Widget buildTopic1(dynamic title) {
    bool tit = title?.topics?.isEmpty ?? true;
    List<Topic> list = title?.topics;
    if (list!.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.cyan.shade100,
          border: Border.all(
            color: Colors.cyan.shade200,
            width: 2,
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 8),
          title: Text(title.name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReadPage(
                        titleId: title.id.toString(),
                        topicId: "",
                      )),
            );
          },
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.teal.shade100,
        border: Border.all(
          color: Colors.teal.shade200,
          width: 2,
        ),
      ),
      child: ExpansionTile(
        title: Text(title.name),
        children: list.map((title) => buildTopic2(title)).toList(),
      ),
    );
  }

  Widget buildTopic2(dynamic title) {
    bool tit = title?.topics?.isEmpty ?? true;
    List<Topic> list = title?.topics;
    if (list!.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.cyan.shade100,
          border: Border.all(
            color: Colors.cyan.shade200,
            width: 2,
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 8),
          title: Text(title.name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReadPage(
                        topicId: title.id.toString(),
                      )),
            );
          },
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.teal.shade100,
        border: Border.all(
          color: Colors.teal.shade200,
          width: 2,
        ),
      ),
      child: ExpansionTile(
        title: Text(title.name),
        children: list.map((title) => buildTopic2(title)).toList(),
      ),
    );
  }
}








//   Widget buildTopic(dynamic title) {
//     return ExpansionTile(
//       title: Text(title.name),
//       children: [
//         title!.topics!.forEach((k, v) {
//           print(v);
//         })
//       ],
//     );
//   }
// }

// class EntryItem extends StatelessWidget {
//   final ChapterModel entry;
//   const EntryItem(this.entry, {Key? key}) : super(key: key);

//   Widget _buildTiles(ChapterModel root) {
//     if (root.topics!.isEmpty) {
//       return ListTile(title: Text(root.name!));
//     }
//     return ExpansionTile(
//       key: PageStorageKey<ChapterModel>(root),
//       title: Text(root.name!),
//       children: root.topics!.map(_buildTiles).toList(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) => _buildTiles(entry);
// }
