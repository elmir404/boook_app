import 'package:boook_app/book_read_page.dart';
import 'package:boook_app/models/section_model.dart';
import 'package:boook_app/services/book_api.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late Future<List<ChapterModel>> _chapterListFuture;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _chapterListFuture = BookApi.getAllChapters();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // ignore: prefer_const_literals_to_create_immutables
      child: ListView(children: <Widget>[
        const UserAccountsDrawerHeader(
          accountName: Text(
            "Mündəricat",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          accountEmail: Text(
            "",
            style: TextStyle(fontSize: 20),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
                fit: BoxFit.cover),
          ),
        ),
        FutureBuilder(
          future: _chapterListFuture,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              List<ChapterModel> _cList = snapshot.data!;

              return ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
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
        )
      ]),
    );
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
