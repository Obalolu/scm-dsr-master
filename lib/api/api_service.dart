import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:dsr/db/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import '../models/devotional_model.dart';


class APIService {
  String? _authToken;
  String? _returnString;
  String? identifier;
  String? username;
  String? email;
  late String password;
  String url = "https://scmdsr-staging.herokuapp.com/devotional-years/?year=2025";
  String tokenUrl = "https://scmdsr-staging.herokuapp.com/auth/local";
  String registerUrl = "https://scmdsr-staging.herokuapp.com/auth/local/register";
  late String loginUrl;

  APIService({this.username, this.email, required this.password, this.identifier});

  Future<String?> getDevotionalData(BuildContext context) async { // Return type is nullable
    try {
      Map<String, String> loginDetails;

      if (username == null && email == null) {
        loginDetails = {
          "identifier": identifier ?? '', // Provide default value if identifier is null
          "password": password
        };
      } else {
        loginDetails = {
          "username": username ?? '', // Provide default value if username is null
          "email": email ?? '', // Provide default value if email is null
          "password": password
        };
      }

      _returnString = await login(loginDetails);
      print("result: ${_returnString ?? 'null'}"); // Handle null value in print statement

      if (_returnString != null && _returnString!.isNotEmpty) { // Check for null and empty string
        return _returnString;
      }

      Map<String, String> authHeader = {"Authorization": "Bearer ${_authToken ?? ''}"}; // Provide default value if _authToken is null

      var response = await http.get(Uri.parse(url), headers: authHeader); // Use Uri.parse for the URL

      Database? db = await DatabaseHelper.instance.database;
      var tableName = DatabaseHelper.devotionalTable;
      var bibleStudyTableName = DatabaseHelper.bibleStudyTable;

      int? count = Sqflite.firstIntValue(
          await db!.rawQuery('SELECT COUNT(*) FROM $tableName'));
      print('number of rows $count');

      int? bsCount = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM $bibleStudyTableName'));
      print('number of bs rows $bsCount');

      if (count == 0 && bsCount == 0) {
        List<DevotionalModel> devotionals = devotionalModelFromJson(
            response.body);

        List<BibleStudy>? bibleStudy = devotionals[0].bibleStudies;
        List<Devotional>? devotional = devotionals[0].devotionals;

        for (int i = 0; i <= bibleStudy!.length - 1; i++) {
          int id = await DatabaseHelper.instance.insertBibleStudy(
              bibleStudy[i].toMap());
          print('The inserted bible study id is $i : $id');
        }

        for (int i = 0; i <= devotional!.length - 1; i++) {
          int id = await DatabaseHelper.instance.insertDevotionals(
              devotional[i].toMap());
          print('The inserted id is : $id');
        }

        return _returnString;
      } else {
        print('Table is not empty');
      }
          return _returnString;
    } on SocketException catch (e) {
      print('CATCH devData: ${e.toString()}.');
      return _returnString;
    }
  }

  Future<String> login(Map<String, String> loginDetails) async {
    try {
      var response = await http.post(loginUrl as Uri, body: loginDetails);

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);

        _authToken = jsonResponse['jwt'];

        print('Token: $_authToken');
        Database? db = await DatabaseHelper.instance.database;
        var tableName = DatabaseHelper.userTable;

        int? count = Sqflite.firstIntValue(
            await db!.rawQuery('SELECT COUNT(*) FROM $tableName'));

        if (count == 0) {
          Map<String, dynamic> row = {
            'username': jsonResponse['user']['username'],
            'email': jsonResponse['user']['email'],
            'reminder': 0,
          };
          int id = await DatabaseHelper.instance.insertUser(row);
          print('The inserted user id is: $id');
        }
              return '';
      } else if (response.statusCode == 400) {
        if (loginUrl == registerUrl) {
          var jsonResponse = convert.jsonDecode(response.body);
          String returnString = await jsonResponse['message'][0]['messages'][0]['message'];
          return returnString;
        }
        return 'username/email or password is incorrect';
      } else {
        return 'Unable to connect to server';
      }
    } on SocketException catch (e) {
      print('CATCH catch: ${e.toString()}.');
      return 'There is no internet connection';
    } catch (e) {
      print('TEST: ${e.toString()}');
      return 'An error occured';
    }
  }
}


