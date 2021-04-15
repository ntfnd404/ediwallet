import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ediwallet/models/Transaction.dart' as TransactionClass;

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "EdiWalletDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Transactions ("
          "id INTEGER PRIMARY KEY,"
          "author TEXT,"
          "department TEXT,"
          "date TEXT,"
          "sum INTEGER,"
          "source TEXT,"
          "time TEXT,"
          "type TEXT,"
          "user TEXT,"
          "mathSymbol TEXT,"
          ")");
    });
  }

  // createRawTransaction(TransactionClass.Transaction newTransaction) async {
  //   final db = await database;
  //   var res = await db.rawInsert("INSERT Into Transactions (author,department)"
  //       " VALUES (${newTransaction.author},${newTransaction.department})");
  //   return res;
  // }

  createTransaction(TransactionClass.Transaction newTransaction) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Transactions");
    int id = table.first["id"];
    //insert to the table using the new id
    return await db.rawInsert(
        "INSERT Into Transactions (id,author,department,date,sum,source,time,type,user,mathSymbol)"
        " VALUES (?,?,?,?,?,?,?,?,?,?)",
        [
          id,
          newTransaction.author,
          newTransaction.department,
          newTransaction.date,
          newTransaction.sum,
          newTransaction.source,
          newTransaction.time,
          newTransaction.type,
          newTransaction.user,
          newTransaction.mathSymbol
        ]);
  }

  getTransaction(int id) async {
    final db = await database;
    var res = await db.query("Transactions", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty
        ? TransactionClass.Transaction.fromJson(res.first)
        : Null;
  }

  getAllTransactions() async {
    final db = await database;
    var res = await db.query("Transactions");
    return res.isNotEmpty
        ? res.map((c) => TransactionClass.Transaction.fromJson(c)).toList()
        : [];
  }

//   Получить только заблокированных клиентов

// getBlockedClients() async {
//     final db = await database;
//     var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
//     List<Client> list =
//         res.isNotEmpty ? res.toList().map((c) => Client.fromMap(c)) : null;
//     return list;
//   }
// Update an existing Client

// updateClient(Client newClient) async {
//     final db = await database;
//     var res = await db.update("Client", newClient.toMap(),
//         where: "id = ?", whereArgs: [newClient.id]);
//     return res;
//   }

// Блокировка/разблокировка клиента

// blockOrUnblock(Client client) async {
//     final db = await database;
//     Client blocked = Client(
//         id: client.id,
//         firstName: client.firstName,
//         lastName: client.lastName,
//         blocked: !client.blocked);
//     var res = await db.update("Client", blocked.toMap(),
//         where: "id = ?", whereArgs: [client.id]);
//     return res;
//   }

// Delete

// Delete one Client

// deleteClient(int id) async {
//     final db = await database;
//     db.delete("Client", where: "id = ?", whereArgs: [id]);
//   }

// Delete All Clients

// deleteAll() async {
//     final db = await database;
//     db.rawDelete("Delete * from Client");
//   }
}
