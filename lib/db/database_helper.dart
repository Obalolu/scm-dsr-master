import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/devotional_model.dart';

class DatabaseHelper {
  static const _dbName = 'scm-dsr.db';
  static const _dbVersion = 1;

  //user table constants
  static const userTable = 'user';
  static const userId = 'id';
  static const username = 'username';
  static const email = 'email';
  static const reminder = 'reminder';
  static const reminderTime = 'reminderTime';

  //devotional table constants
  static const devotionalTable = 'devotional';
  static const id = 'id';
  static const topic = 'topic';
  static const bibleText = 'bibleText';
  static const content = 'content';
  static const day = 'Day';
  static const prayer = 'prayer';
  static const furtherReading = 'furtherReading';
  static const reflection = 'reflection';
  static const devotionalYear = 'devotionalYear';
  static const publishedAt = 'publishedAt';
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
  static const bibletext = 'bibleTextList';
  static const furtherReadings = 'furtherReadingsList';

  //bible_study table constants
  static const bibleStudyTable = 'bibleStudy';
  static const bibleStudyId = 'id';
  static const bibleStudyTopic = 'topic';
  static const bibleStudyBibleText = 'bibleText';
  static const bibleStudyIntroduction = 'introduction';
  static const bibleStudyDiscussion = 'discussion';
  static const bibleStudyConclusion = 'conclusion';
  static const bibleStudyMonth = 'month';
  static const bibleStudyDevotionalYear = 'devotionalYear';
  static const bibleStudyPublishedAt = 'publishedAt';
  static const bibleStudyCreatedAt = 'createdAt';
  static const bibleStudyUpdatedAt = 'updatedAt';
  static const bibleStudyContent = 'content';
  static const bibleStudyMemoryVerse = 'memoryVerse';
  static const bibleStudyBibletext = 'bibleTextList';

  //Making it a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? databases;

  Future<Database?> get database async {
    if (databases != null) return databases;

    databases = await _initiateDatabase();
    return databases;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    db.execute('''
        CREATE TABLE $devotionalTable (
        $id INTEGER PRIMARY KEY,
        $topic TEXT,
        $bibleText TEXT,
        $content TEXT NOT NULL,
        $day NOT NULL,
        $prayer TEXT,
        $furtherReading TEXT,
        $reflection TEXT,
        $devotionalYear TEXT,
        $publishedAt TEXT,
        $createdAt TEXT,
        $updatedAt TEXT,
        $bibletext TEXT,
        $furtherReadings TEXT)
      ''');
    db.execute('''
        CREATE TABLE $bibleStudyTable (
        $bibleStudyId INTEGER PRIMARY KEY,
        $bibleStudyTopic TEXT NOT NULL,
        $bibleStudyBibleText TEXT,
        $bibleStudyIntroduction TEXT,
        $bibleStudyDiscussion TEXT,
        $bibleStudyConclusion TEXT,
        $bibleStudyMonth TEXT NOT NULL,
        $bibleStudyDevotionalYear TEXT,
        $bibleStudyPublishedAt TEXT,
        $bibleStudyCreatedAt TEXT,
        $bibleStudyUpdatedAt TEXT,
        $bibleStudyContent TEXT NOT NULL,
        $bibleStudyMemoryVerse TEXT,
        $bibleStudyBibletext TEXT)
      ''');
    db.execute('''
        CREATE TABLE $userTable (
        $userId INTEGER PRIMARY KEY,
        $username TEXT NOT NULL,
        $email TEXT NOT NULL,
        $reminder INTEGER NOT NULL,
        $reminderTime INTEGER)
      ''');
    print('Database Created');
  }

  Future<int> insertUser(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(userTable, row);
  }

  Future<int> insertDevotionals(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(devotionalTable, row, nullColumnHack: id);
  }

  Future<int> insertBibleStudy(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(bibleStudyTable, row);
  }

  Future<List<Map<String, dynamic>>> queryUser() async {
    Database? db = await instance.database;
    return await db!.query(userTable,
        columns: [userId, username, email, reminder, reminderTime],
        where: '$userId = ?',
        whereArgs: [1]);
  }

  Future<List<Map<String, dynamic>>> queryBibleStudy(String month) async {
    Database? db = await instance.database;

    return await db!.query(bibleStudyTable,
        columns: [
          bibleStudyMonth,
          bibleStudyTopic,
          bibleStudyBibleText,
          bibleStudyBibletext,
          bibleStudyMemoryVerse,
          bibleStudyContent
        ],
        where: '$bibleStudyMonth = ?',
        whereArgs: [month]);
  }

  Future<List<Map<String, dynamic>>> query(String date) async {
    Database? db = await instance.database;
    return await db!.query(devotionalTable,
        columns: [topic, bibleText, day], where: '$day = ?', whereArgs: [date]);
  }

  Future<List<Map<String, dynamic>>> queryReflection(String date) async {
    Database? db = await instance.database;
    return await db!.query(devotionalTable,
        columns: [reflection], where: '$day = ?', whereArgs: [date]);
  }

  Future<List<Map<String, dynamic>>> queryDevotionalCarousel() async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> devotionals = [];
    var newFormat = DateFormat("yyyy-MM-dd");

    for (int i = 3; i >= -3; i--) {
      String date =
      newFormat.format(DateTime.now().subtract(Duration(days: i)));
      final singleDevotionals = await db!.query(devotionalTable,
          columns: [topic, bibleText, day],
          where: '$day = ?',
          whereArgs: [date]);
      devotionals.add(singleDevotionals[0]);
    }
    print('DevLength: ${devotionals.length}');

    return devotionals;
  }

  Future<List<Devotional>> queryByMonth(int monthIndex) async {
    Database? db = await instance.database;
    List<Devotional> allDevotionals = [];
    final monthVariables = <List<dynamic>>[
      ['01-', 31],
      ['02-', 28],
      ['03-', 31],
      ['04-', 30],
      ['05-', 31],
      ['06-', 30],
      ['07-', 31],
      ['08-', 31],
      ['09-', 30],
      ['10-', 31],
      ['11-', 30],
      ['12-', 31],
    ];

    for (int i = 0; i < monthVariables[monthIndex][1]; i++) {
      final dayVariables = [
        '01',
        '02',
        '03',
        '04',
        '05',
        '06',
        '07',
        '08',
        '09',
        '10',
        '11',
        '12',
        '13',
        '14',
        '15',
        '16',
        '17',
        '18',
        '19',
        '20',
        '21',
        '22',
        '23',
        '24',
        '25',
        '26',
        '27',
        '28',
        '29',
        '30',
        '31'
      ];
      String date = '${DateTime.now().year}-${monthVariables[monthIndex][0]}${dayVariables[i]}';
      print(date);
      final singleDevotionals = await db!.query(devotionalTable,
          columns: [topic, bibleText, day],
          where: '$day = ?',
          whereArgs: [date]);

      Map map = singleDevotionals[0];
      print('Map: ${map['Day']}');
      allDevotionals.add(Devotional(
        topic: map['topic'],
        day: DateTime.parse(map['Day']),
        bibleText: map['bibleText'],
      ));
    }
    print('DevLength: ${allDevotionals.length}');

    return allDevotionals;
  }

  Future<int> updateUser(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.update(userTable, row,
        where: '$username = ?', whereArgs: [row['username']]);
  }

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(devotionalTable, where: '$id = ?', whereArgs: [id]);
  }

  Future<bool> deleteDb() async {
    bool databaseDeleted = false;

    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, _dbName);
      await deleteDatabase(path).whenComplete(() {
        databaseDeleted = true;
      }).catchError((onError) {
        databaseDeleted = false;
      });
    } on DatabaseException catch (error) {
      print(error);
    } catch (error) {
      print(error);
    }

    return databaseDeleted;
  }

  Future<int?> isDatabaseNull() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $devotionalTable'));
  }
}
