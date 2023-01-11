import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:contactos/model/Contacto.dart';

class ContactosDatabase {
  static final ContactosDatabase instance = ContactosDatabase._init();

  static Database? _database;

  ContactosDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('contacto.db');
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
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE $tableContactos ( 
      ${ContactoFields.id} $idType, 
      ${ContactoFields.nombre} $integerType,
      ${ContactoFields.apellido} $textType,
      ${ContactoFields.parentesco} $textType,
      ${ContactoFields.correo} $textType,
      ${ContactoFields.celular} $textType
      )
    ''');
  }

  Future<contacto> create(contacto contacto) async {
    final db = await instance.database;

    // final json = Contacto.toJson();
    // final columns =
    //     '${ContactoFields.title}, ${ContactoFields.description}, ${ContactoFields.time}';
    // final values =
    //     '${json[ContactoFields.title]}, ${json[ContactoFields.description]}, ${json[ContactoFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableContactos, contacto.toJson());
    return contacto.copy(id: id);
  }

  Future<contacto> readContacto(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableContactos,
      columns: ContactoFields.values,
      where: '${ContactoFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return contacto.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<contacto>> readAllContactos() async {
    final db = await instance.database;

    final orderBy = '${ContactoFields.id} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableContactoss ORDER BY $orderBy');

    final result = await db.query(tableContactos, orderBy: orderBy);

    return result.map((json) => contacto.fromJson(json)).toList();
  }

  Future<int> update(contacto contacto) async {
    final db = await instance.database;

    return db.update(
      tableContactos,
      contacto.toJson(),
      where: '${ContactoFields.id} = ?',
      whereArgs: [contacto.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableContactos,
      where: '${ContactoFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}