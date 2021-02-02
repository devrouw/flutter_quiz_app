import 'package:flutter_quiz_app/const/const.dart';
import 'package:sqflite/sqflite.dart';

class Question{
  int questionID, isImageQuestion, categoryID;
  String questionText, questionImage, answerA, answerB, answerC, answerD, correctAnswer;

  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{
      columnMainQuestionId:questionID,
      columnMainQuestionText:questionText,
      columnMainQuestionImage:questionImage,
      columnMainQuestionAnswerA:answerA,
      columnMainQuestionAnswerB:answerB,
      columnMainQuestionAnswerC:answerC,
      columnMainQuestionAnswerD:answerD,
      columnMainQuestionCorrectAnswer:correctAnswer,
      columnMainIsImageQuestion:isImageQuestion,
      columnMainQuestionCategoryID:categoryID,
    };
//    return map;
  }

  Question();

  Question.fromMap(Map<String,dynamic> map)
  {
    questionID = map[columnMainQuestionId];
    questionText = map[columnMainQuestionText];
    questionImage = map[columnMainQuestionImage];
    answerA = map[columnMainQuestionAnswerA];
    answerB = map[columnMainQuestionAnswerB];
    answerC = map[columnMainQuestionAnswerC];
    answerD = map[columnMainQuestionAnswerD];
    correctAnswer = map[columnMainQuestionCorrectAnswer];
    isImageQuestion = map[columnMainIsImageQuestion];
    categoryID = map[columnMainQuestionCategoryID];
  }
}

class QuestionProvider{
  Future<Question> getQuestionById(Database db, int id) async{
    var maps = await db.query(tableQuestionName,
        columns: [
          columnMainQuestionId,
          columnMainQuestionText,
          columnMainQuestionImage,
          columnMainQuestionAnswerA,
          columnMainQuestionAnswerB,
          columnMainQuestionAnswerC,
          columnMainQuestionAnswerD,
          columnMainQuestionCorrectAnswer,
          columnMainIsImageQuestion,
          columnMainQuestionCategoryID,
        ], where: '$columnMainQuestionId=?',
        whereArgs: [id]);
    if(maps.length > 0)
      return Question.fromMap(maps.first);
    return null;
  }

  Future<List<Question>> getQuestionByCategoryId(Database db, int id) async{
    var maps = await db.query(tableQuestionName,
        columns: [
          columnMainQuestionId,
          columnMainQuestionText,
          columnMainQuestionImage,
          columnMainQuestionAnswerA,
          columnMainQuestionAnswerB,
          columnMainQuestionAnswerC,
          columnMainQuestionAnswerD,
          columnMainQuestionCorrectAnswer,
          columnMainIsImageQuestion,
          columnMainQuestionCategoryID,
        ], where: '$columnMainQuestionCategoryID=?',
        whereArgs: [id]);
    if(maps.length > 0)
      return maps.map((question) => Question.fromMap(question)).toList();
    return null;
  }

  Future<List<Question>> getQuestions(Database db) async{
    var maps = await db.query(tableQuestionName,
        columns: [
          columnMainQuestionId,
          columnMainQuestionText,
          columnMainQuestionImage,
          columnMainQuestionAnswerA,
          columnMainQuestionAnswerB,
          columnMainQuestionAnswerC,
          columnMainQuestionAnswerD,
          columnMainQuestionCorrectAnswer,
          columnMainIsImageQuestion,
          columnMainQuestionCategoryID,
        ], orderBy: "Random()");
    if(maps.length > 0)
      return maps.map((question) => Question.fromMap(question)).toList();
    return null;
  }
}