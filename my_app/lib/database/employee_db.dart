import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:my_app/helper/employee.dart';


class EmployeeDatabase {
  static final EmployeeDatabase instance = EmployeeDatabase._init();

  static Database? _database;

  EmployeeDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('employee_db.db');
    return _database!;

  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async{
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final emailType = 'TEXT NOT NULL';
    final passwordType = 'TEXT NOT NULL';
    final nameType = 'TEXT NOT NULL';

    await db.execute("""
    CREATE TABLE $tableEmployee(
    ${EmployeeFields.id} $idType,
    ${EmployeeFields.email} $emailType,
    ${EmployeeFields.password} $passwordType,
    ${EmployeeFields.name} $nameType
    )
    
    """);
  }

  Future<Employee> create(Employee employee) async {
    final db = await instance.database;
    
    final id  = await db.insert(tableEmployee, employee.toJson());
    return employee.copy(id:id);
  }

  Future<Employee> readEmployee(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableEmployee,
      columns: EmployeeFields.values,
      where: '${EmployeeFields.id} =?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty){
      return Employee.fromJson(maps.first);
    }
    else{
      throw Exception('ID $id not found');
    }
  }

  Future<List<Employee>> readAllEmployees() async {
    final db = await instance.database;
    final orderBy = '${EmployeeFields.name} ASC';
    final result = await db.query(tableEmployee, orderBy: orderBy);
    // ^ or db.query('SELECT * FROM $tableEmployee ORDER BY $oderBy')
    return result.map((json) => Employee.fromJson(json)).toList();
  }

  Future<int> update(Employee employee) async {
    final db = await instance.database;

    return db.update(
      tableEmployee,
      employee.toJson(),
      where: '${EmployeeFields.id} = ?',
      whereArgs: [employee.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableEmployee,
      where: '${EmployeeFields.id} = ?',
      whereArgs: [id],
    );
  }


  Future close() async {
    final db = await instance.database;
    db.close();
  }

}