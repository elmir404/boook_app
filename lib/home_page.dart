import 'package:boook_app/book_read_page.dart';
import 'package:boook_app/main_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.topRight,
              colors: [
                Color(0xFFA7FFEB),
                Color(0xFFC8E6C9),
                Color(0XFFFFAB91)
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Divider(
              height: 10,
              color: Colors.black54,
            ),
            Container(
              child: Image.asset(
                'assets/home.jpg',
                height: 400,
                width: 800,
              ),
            ),
            Divider(
              height: 10,
              color: Color.fromARGB(137, 2, 1, 1),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReadPage(
                            titleId: "",
                            topicId: "",
                          )),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 28, right: 28, bottom: 8, top: 8),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xFF26C6DA), Color(0XFF00796B)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.shade500.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 100,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.menu,
                          size: 50,
                          color: Colors.black45,
                        ),
                        const Text(
                          "Oxumağa başla",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),
                        Icon(
                          Icons.menu,
                          size: 50,
                          color: Colors.black45,
                        )
                      ]),
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => ReadPage(
            //                 lessonId: 1,
            //               )),
            //     );
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.only(
            //         left: 28, right: 28, bottom: 8, top: 8),
            //     child: Container(
            //       decoration: BoxDecoration(
            //         gradient: const LinearGradient(
            //             colors: [Color(0xFF26C6DA), Color(0XFF00796B)],
            //             begin: Alignment.bottomLeft,
            //             end: Alignment.topRight),
            //         borderRadius: BorderRadius.circular(25),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.teal.shade500.withOpacity(0.5),
            //             spreadRadius: 5,
            //             blurRadius: 7,
            //             offset: Offset(0, 3), // changes position of shadow
            //           ),
            //         ],
            //       ),
            //       height: 100,
            //       child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: const [
            //             Icon(
            //               Icons.menu,
            //               size: 50,
            //               color: Colors.black45,
            //             ),
            //             const Text(
            //               "Davam et ",
            //               style: TextStyle(
            //                   color: Colors.black54,
            //                   fontSize: 30,
            //                   fontWeight: FontWeight.w800),
            //             ),
            //             Icon(
            //               Icons.menu,
            //               size: 50,
            //               color: Colors.black45,
            //             )
            //           ]),
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainMenu()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 28, right: 28, bottom: 8, top: 8),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xFF26C6DA), Color(0XFF00796B)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.shade500.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 100,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.menu,
                          size: 50,
                          color: Colors.black45,
                        ),
                        const Text(
                          "Mündəricat",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),
                        Icon(
                          Icons.menu,
                          size: 50,
                          color: Colors.black45,
                        )
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
