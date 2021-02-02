import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/screens/home_page.dart';
import 'package:flutter_quiz_app/screens/question_detail.dart';
import 'package:flutter_quiz_app/screens/read_mode.dart';
import 'package:flutter_quiz_app/screens/show_result.dart';
import 'package:flutter_quiz_app/screens/test_mode.dart';
import 'package:flutter_riverpod/all.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        "/homePage": (context) => MyCategoryPage(title: 'My Quiz',),
        "/readMode": (context) => ReadModePage(),
        "/testMode": (context) => TestModePage(),
        "/showResult": (context) => ResultPage(),
        "/questionDetail": (context) => QuestionDetailPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'EDMT Quiz App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pop();
      Navigator.pushNamed(context, "/homePage");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
  
}
