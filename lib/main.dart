import 'package:boook_app/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  // DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  // void getCurrentAppTheme() async {
  //   themeChangeProvider.setDarkTheme =
  //       await themeChangeProvider.darkThemePrefs.getTheme();
  // }

  @override
  void initState() {
    // getCurrentAppTheme();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
