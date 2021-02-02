import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/database/db_helper.dart';
import 'package:flutter_quiz_app/database/question_provider.dart';
import 'package:flutter_quiz_app/model/user_answer.dart';
import 'package:flutter_quiz_app/state/state_manager.dart';
import 'package:flutter_quiz_app/utils/utils.dart';
import 'package:flutter_quiz_app/widgets/question_body.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/all.dart';

class ReadModePage extends StatefulWidget {
  ReadModePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ReadModePageState createState() => _ReadModePageState();
}

class _ReadModePageState extends State<ReadModePage> {
  SharedPreferences prefs;
  int indexPage = 0;
  CarouselController buttonCarouselController = CarouselController();
  List<UserAnswer> userAnswers = new List<UserAnswer>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      prefs = await SharedPreferences.getInstance();
      indexPage = await prefs.getInt(
          '${context.read(questionCategoryState).state.name}_${context.read(questionCategoryState).state.ID}');
      Future.delayed(Duration(milliseconds: 500)).then((value) =>
          buttonCarouselController
              .animateToPage(indexPage == null ? 0 : indexPage));
    });
  }

  @override
  Widget build(BuildContext context) {
    var questionModule = context.read(questionCategoryState).state;
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(questionModule.name),
            leading: GestureDetector(
              onTap: () => showCloseDialog(questionModule),
              child: Icon(Icons.arrow_back),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: FutureBuilder<List<Question>>(
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                else if (snapshot.hasData) {
                  if (snapshot.data.length > 0) {
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      child: Card(
                        elevation: 8,
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 4, right: 4, bottom: 4, top: 10),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                QuestionBody(
                                  context: context,
                                  buttonCarouselController:
                                      buttonCarouselController,
                                  questions: snapshot.data,
                                  userAnswers: userAnswers,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FlatButton(
                                        onPressed: () => showAnswer(context),
                                        child: Text('Show Answer'))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  else return Center(child: Text('Category don\'t have any question'),);
                }
                else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              },
              future: getQuestionByCategory(questionModule.ID),
            ),
          ),
        ),
        onWillPop: () async {
          showCloseDialog(questionModule);
          return true;
        });
  }

  showCloseDialog(questionModule) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: Text('Close'),
              content: Text('Do you want to save this question index?'),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                  },
                  child: Text('No'),
                ),
                FlatButton(
                  onPressed: () {
                    prefs.setInt(
                        '${context.read(questionCategoryState).state.name}_${context.read(questionCategoryState).state.ID}',
                        context.read(currentReadPage).state);
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                  },
                  child: Text('Yes'),
                ),
              ],
            ));
  }

  Future<List<Question>> getQuestionByCategory(int id) async {
    var db = await copyDB();
    var result = await QuestionProvider().getQuestionByCategoryId(db, id);
    return result;
  }
}
