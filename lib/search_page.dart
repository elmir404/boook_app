import 'package:boook_app/models/paragraph_model.dart';
import 'package:boook_app/services/book_api.dart';

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_all/flutter_html_all.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<ParagraphModel>> _paragraphListFuture;
  late int listIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _paragraphListFuture = BookApi.searchParagraphs("saasdsadsad");
    listIndex = 0;
  }

  ItemScrollController _scrollController = ItemScrollController();

  double getRadianFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final panelHeightClosed = size.height * 0.025;
    final panelHeightOpen = size.height * 0.4;
    return Scaffold(
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
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
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
                    if (val != '') {
                      setState(() {
                        _paragraphListFuture = BookApi.searchParagraphs(val);
                      });
                    }
                  },
                ),
              ))),
      body: Container(
          width: size.width,
          height: size.height,
          child: FutureBuilder(
            future: _paragraphListFuture,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                List<ParagraphModel> _pList = snapshot.data!;
                return Column(
                  children: [
                    Dismissible(
                        key: UniqueKey(),
                        child: Column(
                          children: [
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Center(
                                child: Text(
                                  _pList.length.toString() + " nəticə tapıldı",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade400),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Colors.teal),
                                  ),
                                  onPressed: listIndex == 0
                                      ? null
                                      : () {
                                          listIndex--;

                                          _scrollController.scrollTo(
                                              index: listIndex,
                                              duration: Duration(seconds: 1));
                                          setState(() {
                                            listIndex = listIndex;
                                          });
                                        },
                                  child: Text("Əvvəl"),
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              Colors.teal),
                                    ),
                                    onPressed: listIndex == _pList.length - 1
                                        ? null
                                        : () {
                                            listIndex++;

                                            _scrollController.scrollTo(
                                                index: listIndex,
                                                duration: Duration(seconds: 1));
                                            setState(() {
                                              listIndex = listIndex;
                                            });
                                          },
                                    child: Text("Sonra")),
                              ],
                            )
                          ],
                        )),
                    Expanded(
                      child: ScrollablePositionedList.builder(
                        // scrollDirection: Axis.vertical,

                        // shrinkWrap: true,
                        itemScrollController: _scrollController,
                        itemCount: _pList.length,
                        itemBuilder: (context, index) {
                          var currentParagraph = _pList[index];
                          var text = "${currentParagraph.description}";
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    5), //border corner radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), //color of shadow
                                    spreadRadius: 5, //spread radius
                                    blurRadius: 7, // blur radius
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                    //first paramerter of offset is left-right
                                    //second parameter is top to down
                                  ),
                                  //you can set more BoxShadow() here
                                ],
                              ),
                              width: size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image.network(
                                  //     "https://kruschecompany.com/wp-content/uploads/2022/09/Hero-image-for-analysis-of-international-Flutter-developer-salary-ranges-with-data-covering-Germany-Switzerland-United-Kingdom-Eastern-Europe-India-and-USA.jpg" ??
                                  //         ""),
                                  Html(
                                    data: text,
                                    shrinkWrap: false,
                                    style: {
                                      "table": Style(
                                        backgroundColor: Color.fromARGB(
                                            0x50, 0xee, 0xee, 0xee),
                                      ),
                                      "tr": Style(
                                        border: Border(
                                            bottom:
                                                BorderSide(color: Colors.grey)),
                                      ),
                                      "th": Style(
                                        padding: EdgeInsets.all(6),
                                        backgroundColor: Colors.grey,
                                      ),
                                      "td": Style(
                                        padding: EdgeInsets.all(6),
                                        alignment: Alignment.topLeft,
                                      ),
                                    },
                                    customRenders: {
                                      tagMatcher("table"): CustomRender.widget(
                                          widget: (context, buildChildren) =>
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: tableRender
                                                    .call()
                                                    .widget!
                                                    .call(
                                                        context, buildChildren),
                                              )),
                                      networkSourceMatcher(
                                              domains: ["mydomain.com"]):
                                          networkImageRender(
                                        headers: {
                                          "Custom-Header": "some-value"
                                        },
                                        altWidget: (alt) => Text(alt ?? ""),
                                        loadingWidget: () => Text("Loading..."),
                                      ),
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center();
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          )),
    );
  }
}
