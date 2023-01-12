import 'package:contactos/model/contactos.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactosDatabase {
  static final ContactosDatabase instance = ContactosDatabase._init();

  static Database? _database;

  ContactosDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('conta1.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableContactos (
      ${ContactosFields.id} $idType, 
      ${ContactosFields.nombres} $textType,
      ${ContactosFields.apellidos} $textType,
      ${ContactosFields.parentesco} $textType,
      ${ContactosFields.correo} $textType,
      ${ContactosFields.telefono} $textType
      )
    ''');
  }

  Future<Contactos> create(Contactos contactos) async {
    final db = await instance.database;

    final id = await db.insert(tableContactos, contactos.toJson());
    return contactos.copy(id: id);
  }

  Future<Contactos> readContactos(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableContactos,
      columns: ContactosFields.values,
      where: '${ContactosFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Contactos.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Contactos>> readAllContactos() async {
    final db = await instance.database;

    final orderBy = '${ContactosFields.id} ASC';

    final result = await db.query(tableContactos, orderBy: orderBy);

    return result.map((json) => Contactos.fromJson(json)).toList();
  }

  Future<int> update(Contactos contactos) async {
    final db = await instance.database;

    return db.update(
      tableContactos,
      contactos.toJson(),
      where: '${ContactosFields.id} = ?',
      whereArgs: [contactos.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableContactos,
      where: '${ContactosFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
