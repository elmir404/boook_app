import 'package:boook_app/models/paragraph_model.dart';
import 'package:boook_app/navbar.dart';
import 'package:boook_app/search_page.dart';
import 'package:boook_app/services/book_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_all/flutter_html_all.dart';

class ReadPage extends StatefulWidget {
  final String titleId;
  final String topicId;
  final double brightnes;
  final double textSize;

  const ReadPage(
      {super.key,
      this.titleId = "",
      this.topicId = "",
      this.brightnes = 0,
      this.textSize = 0});

  @override
  _ReadPageState createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  late Future<List<ParagraphModel>> _paragraphListFuture;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  bool _isFirstLoading = false;

  List<ParagraphModel> _paragraphs = [];
  int _page = 1;
  late ScrollController _controller;
  final listViewKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.titleId == "" && widget.topicId == "") {
      _paragraphListFuture = BookApi.getParagraphs(
          widget.titleId, widget.topicId, _page.toString());

      _controller = ScrollController()..addListener(_loadMore);
    } else {
      _paragraphListFuture = BookApi.getParagraphs(
          widget.titleId, widget.topicId, _page.toString());
      _controller = ScrollController();
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // dispose the controller
    super.dispose();
  }
  // void _firstLoad() async {
  //   setState(() {
  //     _isFirstLoading = true;
  //   });

  //   setState(() {
  //     _paragraphListFuture.then((newData) async {
  //       _paragraphs = await newData;
  //     });
  //   });
  //   setState(() {
  //     _isFirstLoading = false;
  //   });
  // }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isLoadMoreRunning == false &&
        _controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _page += 1;
      _paragraphListFuture = BookApi.getParagraphs(
          widget.titleId, widget.topicId, _page.toString());
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        _controller.animateTo(_controller.position.minScrollExtent,
            duration: const Duration(milliseconds: 1),
            curve: Curves.fastOutSlowIn);
      });
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // void _loadAfter() async {
  //   if (_hasNextPage == true &&
  //       _isLoadMoreRunning == false &&
  //       _controller.position.pixels == _controller.position.minScrollExtent) {
  //     setState(() {
  //       _isLoadMoreRunning = true;
  //     });
  //     if (_page > 1) {
  //       _page += 1;
  //       _paragraphListFuture = BookApi.getParagraphs(
  //           widget.titleId, widget.topicId, _page.toString());
  //       SchedulerBinding.instance?.addPostFrameCallback((_) {
  //         _controller.animateTo(_controller.position.maxScrollExtent,
  //             duration: const Duration(milliseconds: 1),
  //             curve: Curves.fastOutSlowIn);
  //       });
  //       setState(() {
  //         _isLoadMoreRunning = false;
  //       });
  //     }
  //   }
  // }

  double _initialScale = 1.0;
  double _scaleFactor = 1.0;
  double _currentScale = 1.0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
          title: Text("55 Dərsə Excell"),
          backgroundColor: Colors.teal.shade200,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchPage())),
                icon: const Icon(Icons.search))
          ]),
      body: Zoom(
          opacityScrollBars: 0.0,
          doubleTapZoom: true,
          maxZoomWidth: size.width,
          maxZoomHeight: size.height,
          enableScroll: true,
          child: Container(
              width: size.width,
              height: size.height,
              child: FutureBuilder(
                future: _paragraphListFuture,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    List<ParagraphModel> _pList = snapshot.data!;
                    return ListView.builder(
                      // scrollDirection: Axis.vertical,
                      key: listViewKey,
                      // shrinkWrap: true,
                      controller: _controller,
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
                                              scrollDirection: Axis.horizontal,
                                              child: tableRender
                                                  .call()
                                                  .widget!
                                                  .call(context, buildChildren),
                                            )),
                                    networkSourceMatcher(
                                            domains: ["mydomain.com"]):
                                        networkImageRender(
                                      headers: {"Custom-Header": "some-value"},
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
                    );
                  } else if (snapshot.hasError) {
                    return Center();
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
              ))),
    );
  }

  void getAfter(int id) async {
    setState(() {
      _paragraphListFuture = BookApi.getAfterParagraphById(id);
    });
  }

  void getBefore(int id) async {
    late Future<List<ParagraphModel>> list = BookApi.getBeforeParagraphById(id);
    setState(() {
      _paragraphListFuture = list;
    });
  }
}
