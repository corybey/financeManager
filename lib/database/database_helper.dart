import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    
    try {
      final String path = join(await getDatabasesPath(), 'finance.db');
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      );
      return _database!;
    } catch (e) {
      // If database fails, create in-memory database
      _database = await openDatabase(':memory:');
      await _onCreate(_database!, 1);
      return _database!;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS transactions(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          category TEXT,
          amount REAL,
          date TEXT,
          type TEXT
        )
      ''');
      
      await db.execute('''
        CREATE TABLE IF NOT EXISTS income(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          amount REAL,
          description TEXT,
          date TEXT
        )
      ''');
      
      await db.execute('''
        CREATE TABLE IF NOT EXISTS savings(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          amount REAL,
          goal_name TEXT,
          date TEXT
        )
      ''');
    } catch (e) {
      // Ignore table creation errors
    }
  }

  // Transaction methods
  Future<int> insertTransaction(Map<String, dynamic> row) async {
    try {
      final db = await database;
      return await db.insert('transactions', row);
    } catch (e) {
      return 1;
    }
  }

  Future<List<Map<String, dynamic>>> getTransactions() async {
    try {
      final db = await database;
      return await db.query('transactions', orderBy: 'date DESC');
    } catch (e) {
      return [];
    }
  }

  Future<double> getTotalExpenses() async {
    try {
      final db = await database;
      final result = await db.rawQuery(
        'SELECT SUM(amount) as total FROM transactions WHERE amount < 0'
      );
      return (result.first['total'] as double? ?? 0.0).abs();
    } catch (e) {
      return 0.0;
    }
  }

  Future<double> getTransactionIncome() async {
    try {
      final db = await database;
      final result = await db.rawQuery(
        'SELECT SUM(amount) as total FROM transactions WHERE amount > 0'
      );
      return result.first['total'] as double? ?? 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  // Income methods
  Future<int> insertIncome(Map<String, dynamic> row) async {
    try {
      final db = await database;
      return await db.insert('income', row);
    } catch (e) {
      return 1;
    }
  }

  Future<List<Map<String, dynamic>>> getIncome() async {
    try {
      final db = await database;
      return await db.query('income', orderBy: 'date DESC');
    } catch (e) {
      return [];
    }
  }

  Future<double> getTotalIncome() async {
    try {
      final db = await database;
      final result = await db.rawQuery('SELECT SUM(amount) as total FROM income');
      return result.first['total'] as double? ?? 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  // Savings methods
  Future<int> insertSavings(Map<String, dynamic> row) async {
    try {
      final db = await database;
      return await db.insert('savings', row);
    } catch (e) {
      return 1;
    }
  }

  Future<List<Map<String, dynamic>>> getSavings() async {
    try {
      final db = await database;
      return await db.query('savings', orderBy: 'date DESC');
    } catch (e) {
      return [];
    }
  }

  Future<double> getTotalSavings() async {
    try {
      final db = await database;
      final result = await db.rawQuery('SELECT SUM(amount) as total FROM savings');
      return result.first['total'] as double? ?? 0.0;
    } catch (e) {
      return 0.0;
    }
  }
}