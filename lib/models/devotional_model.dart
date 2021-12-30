// To parse this JSON data, do
//
//     final devotionalModel = devotionalModelFromJson(jsonString);

import 'dart:convert';

import 'package:devotional/db/database_helper.dart';

List<DevotionalModel> devotionalModelFromJson(String str) =>
    List<DevotionalModel>.from(
        json.decode(str).map((x) => DevotionalModel.fromJson(x)));

String devotionalModelToJson(List<DevotionalModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DevotionalModel {
  DevotionalModel({
    this.id,
    this.isCompleted,
    this.theme,
    this.year,
    this.createdAt,
    this.updatedAt,
    this.devotionals,
    this.bibleStudies,
  });

  int id;
  bool isCompleted;
  String theme;
  int year;
  DateTime createdAt;
  DateTime updatedAt;
  List<Devotional> devotionals;
  List<BibleStudy> bibleStudies;

  factory DevotionalModel.fromJson(Map<String, dynamic> json) =>
      DevotionalModel(
        id: json["id"],
        isCompleted: json["is_completed"],
        theme: json["theme"],
        year: json["year"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        devotionals: List<Devotional>.from(
            json["devotionals"].map((x) => Devotional.fromJson(x))),
        bibleStudies: List<BibleStudy>.from(
            json["bible_studies"].map((x) => BibleStudy.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "is_completed": isCompleted,
        "theme": theme,
        "year": year,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "devotionals": List<dynamic>.from(devotionals.map((x) => x.toJson())),
        "bible_studies": List<dynamic>.from(
            bibleStudies.map((x) => x.toJson())),
      };
}

class BibleStudy {
  BibleStudy({
    this.id,
    this.topic,
    this.bibleText,
    this.introduction,
    this.discussion,
    this.conclusion,
    this.month,
    this.devotionalYear,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.content,
    this.memoryVerse,
    this.bibletext,
  });

  int id;
  String topic;
  String bibleText;
  dynamic introduction;
  dynamic discussion;
  dynamic conclusion;
  String month;
  int devotionalYear;
  DateTime publishedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String content;
  String memoryVerse;
  List<Bibletext> bibletext;

  factory BibleStudy.fromJson(Map<String, dynamic> json) =>
      BibleStudy(
        id: json["id"],
        topic: json["topic"],
        bibleText: json["bible_text"],
        introduction: json["introduction"],
        discussion: json["discussion"],
        conclusion: json["conclusion"],
        month: json["month"],
        devotionalYear: json["devotional_year"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        content: json["content"],
        memoryVerse: json["memory_verse"],
        bibletext: List<Bibletext>.from(
            json["bibletext"].map((x) => Bibletext.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "topic": topic,
        "bible_text": bibleText,
        "introduction": introduction,
        "discussion": discussion,
        "conclusion": conclusion,
        "month": month,
        "devotional_year": devotionalYear,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "content": content,
        "memory_verse": memoryVerse,
        "bibletext": List<dynamic>.from(bibletext.map((x) => x.toJson())),
      };

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.bibleStudyId: id,
      DatabaseHelper.bibleStudyTopic: topic,
      DatabaseHelper.bibleStudyBibleText: bibleText,
      DatabaseHelper.bibleStudyIntroduction: introduction,
      DatabaseHelper.bibleStudyDiscussion: discussion,
      DatabaseHelper.bibleStudyConclusion: conclusion,
      DatabaseHelper.bibleStudyMonth: month,
      DatabaseHelper.bibleStudyDevotionalYear: devotionalYear,
      DatabaseHelper.bibleStudyPublishedAt: publishedAt.toIso8601String(),
      DatabaseHelper.bibleStudyCreatedAt: createdAt.toIso8601String(),
      DatabaseHelper.bibleStudyUpdatedAt: updatedAt.toIso8601String(),
      DatabaseHelper.bibleStudyContent: content,
      DatabaseHelper.bibleStudyMemoryVerse: memoryVerse,
      DatabaseHelper.bibleStudyBibletext: jsonEncode(
          List<dynamic>.from(bibletext.map((x) => x.toJson()))),
    };
  }

}

class Bibletext {
  Bibletext({
    this.id,
    this.name,
    this.content,
  });

  int id;
  String name;
  String content;

  factory Bibletext.fromJson(Map<String, dynamic> json) =>
      Bibletext(
        id: json["id"],
        name: json["name"],
        content: json["content"] == null ? null : json["content"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "content": content == null ? null : content,
      };
}

class Devotional {
    Devotional({
        this.id,
        this.topic,
        this.bibleText,
        this.content,
        this.day,
        this.prayer,
        this.furtherReading,
        this.reflection,
      this.devotionalYear,
        this.publishedAt,
      this.createdAt,
      this.updatedAt,
      this.bibletext,
      this.furtherReadings,
    });

    int id;
    String topic;
    String bibleText;
    String content;
    DateTime day;
    String prayer;
    String furtherReading;
    String reflection;
    int devotionalYear;
    DateTime publishedAt;
    DateTime createdAt;
    DateTime updatedAt;
    List<Bibletext> bibletext;
    List<Bibletext> furtherReadings;

    factory Devotional.fromJson(Map<String, dynamic> json) => Devotional(
        id: json["id"],
        topic: json["Topic"],
        bibleText: json["bible_text"],
        content: json["content"],
      day: DateTime.parse(json["Day"]),
        prayer: json["prayer"],
        furtherReading: json["further_reading"],
        reflection: json["reflection"],
      devotionalYear: json["devotional_year"],
      publishedAt: DateTime.parse(json["published_at"]),
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      bibletext: List<Bibletext>.from(
          json["bibletext"].map((x) => Bibletext.fromJson(x))),
      furtherReadings: List<Bibletext>.from(
          json["further_readings"].map((x) => Bibletext.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "Topic": topic,
        "bible_text": bibleText,
        "content": content,
      "Day": "${day.year.toString().padLeft(4, '0')}-${day.month.toString()
          .padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}",
        "prayer": prayer,
        "further_reading": furtherReading,
        "reflection": reflection,
      "devotional_year": devotionalYear,
      "published_at": publishedAt.toIso8601String(),
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "bibletext": List<dynamic>.from(bibletext.map((x) => x.toJson())),
      "further_readings": List<dynamic>.from(
          furtherReadings.map((x) => x.toJson())),
    };

    Map<String, dynamic> toMap() {
        return {
          DatabaseHelper.id: id,
          DatabaseHelper.topic: topic,
          DatabaseHelper.bibleText: bibleText,
          DatabaseHelper.content: content,
          DatabaseHelper.day: '${day.year.toString().padLeft(4, '0')}-${day
              .month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(
              2, '0')}',
          DatabaseHelper.prayer: prayer,
          DatabaseHelper.furtherReading: furtherReading,
          DatabaseHelper.reflection: reflection,
          DatabaseHelper.devotionalYear: devotionalYear,
          DatabaseHelper.publishedAt: publishedAt.toIso8601String(),
          DatabaseHelper.createdAt: createdAt.toIso8601String(),
          DatabaseHelper.updatedAt: updatedAt.toIso8601String(),
          DatabaseHelper.bibletext: jsonEncode(
              List<dynamic>.from(bibletext.map((x) => x.toJson()))),
          DatabaseHelper.furtherReadings: jsonEncode(
              List<dynamic>.from(furtherReadings.map((x) => x.toJson()))),
        };
    }

}