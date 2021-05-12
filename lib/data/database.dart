import 'dart:async';
import 'dart:io';
import 'package:ediwallet/models/dds.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ediwallet/models/transaction.dart' as wallet_transaction;

// https://habr.com/ru/post/435418/

class DBProvider {
  Database? _database;
  Database? get database => _database;

  DBProvider._();
  static final DBProvider db = DBProvider._();

  Future<Database> initDB() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();

    final String databasePath = join(documentsDirectory.path, 'EdiWalletDB.db');

    return openDatabase(databasePath, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      // await db.execute('CREATE TABLE Transactions ( '
      //     'id INTEGER PRIMARY KEY, '
      //     'author TEXT, '
      //     'department TEXT, '
      //     'date TEXT, '
      //     'sum INTEGER, '
      //     'source TEXT, '
      //     'time TEXT, '
      //     'type TEXT, '
      //     'user TEXT, '
      //     'mathSymbol TEXT, '
      //     ')');

      await db.execute('CREATE TABLE DDS ( '
          'id TEXT PRIMARY KEY, '
          'name TEXT '
          ')');
    });
  }

  Future<int> createTransaction(
      wallet_transaction.Transaction newTransaction) async {
    // final db = database;
    //get the biggest id in the table
    final table =
        await database!.rawQuery('SELECT MAX(id)+1 as id FROM Transactions');
    final Object id = table.first['id']!;
    //insert to the table using the new id
    return _database!.rawInsert(
        'INSERT Into Transactions (id,author,department,date,sum,source,time,type,user,mathSymbol)'
        ' VALUES (?,?,?,?,?,?,?,?,?,?)',
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

  Future getTransaction(int id) async {
    final res =
        await database!.query('Transactions', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty
        ? wallet_transaction.Transaction.fromJson(res.first)
        : Null;
  }

  Future<List> getAllTransactions() async {
    final res = await database!.query('Transactions');
    return res.isNotEmpty
        ? res.map((c) => wallet_transaction.Transaction.fromJson(c)).toList()
        : List<wallet_transaction.Transaction>.empty();
  }

  Future deleteAllTransactios() async {
    final db = database;
    await db!.rawDelete("Delete * from Transactions");
  }

  Future getDDS(String id) async {
    final res = await database!.query('DDS', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty
        ? DDS.fromJson(res.first as Map<String, String>)
        : Null;
  }

  Future<List> getAllDDS() async {
    final res = await database!.query('DDS');
    return res.isNotEmpty
        ? res.map((dds) => DDS.fromJson(dds as Map<String, String>)).toList()
        : List<DDS>.empty();
  }

  Future deleteAllDDS() async {
    final db = database;
    await db!.rawDelete("Delete * from DDS");
  }

// createRawTransaction(TransactionClass.Transaction newTransaction) async {
  //   final db = await database;
  //   var res = await db.rawInsert("INSERT Into Transactions (author,department)"
  //       " VALUES (${newTransaction.author},${newTransaction.department})");
  //   return res;
  // }

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

// Рефакторинг для использования BLoC паттерна
// //
// 1. getClients получает данные из БД (Client table) асинхронно. Мы будем использовать этот метод всегда, когда нам будет необходимо обновить таблицу, следовательно стоит поместить его в тело конструктора.

// 2. Мы создали StreamController.broadcast, для того чтобы слушать широковещательные события более одного раза. В нашем примере это не имеет особо значения, поскольку мы слушаем их только один раз, но неплохо было бы реализовать это на будущее.

// 3. Не забываем закрывать потоки. Таким образом мы предотвратим мемори лики. В нашем примере мы закрываем их используя dispose method в StatefulWidget

// lass ClientsBloc {
//   ClientsBloc() {
//     getClients();
//   }
//   final _clientController =     StreamController<List<Client>>.broadcast();
//   get clients => _clientController.stream;

//   dispose() {
//     _clientController.close();
//   }

//   getClients() async {
//     _clientController.sink.add(await DBProvider.db.getAllClients());
//   }
// }
//
// blockUnblock(Client client) {
//   DBProvider.db.blockOrUnblock(client);
//   getClients();
// }

// delete(int id) {
//   DBProvider.db.deleteClient(id);
//   getClients();
// }

// add(Client client) {
//   DBProvider.db.newClient(client);
//   getClients();
// }
