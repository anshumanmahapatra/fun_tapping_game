import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/play_model.dart';


class PlayDatabase {
  static final PlayDatabase instance = PlayDatabase.init();

  static Database? _database;

  PlayDatabase.init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    debugPrint("Database creation started");
    _database = await _initDB('play.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';

    final integerType = 'INTEGER NOT NULL';

    await db.execute('''CREATE TABLE $tablePlay (
      ${PlayFields.id} $idType,
      ${PlayFields.totalGames} $integerType,
      ${PlayFields.player1Streak} $integerType,
      ${PlayFields.player2Streak} $integerType,
      ${PlayFields.player1Wins} $integerType,
      ${PlayFields.player2Wins} $integerType,
      ${PlayFields.player1CurrentStreak} $integerType,
      ${PlayFields.player2CurrentStreak} $integerType
      )''');

    debugPrint("Database creation successful");
  }

  Future<int> createFirstEntry(PlayModel playModel) async {
    final db = await instance.database;

    final id = await db.insert(tablePlay, playModel.toJson());

    debugPrint("Id created: $id");

    // return playModel.copy(id: id);

    return id;
  }

  Future<List<PlayModel>> readAllNotes() async {
    debugPrint("Reading all entries");
    final db = await instance.database;

    final result = await db.query(tablePlay);

    return result.map((json) => PlayModel.fromJson(json)).toList();
  }

  Future<int> update(PlayModel playModel) async {
    debugPrint('Updating entry');
    final db = await instance.database;

    return db.update(tablePlay, playModel.toJson(),
        where: '${PlayFields.id} = ?', whereArgs: [playModel.id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
