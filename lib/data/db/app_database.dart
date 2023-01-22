import 'dart:async';

import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase _singleton = AppDatabase._();
  static AppDatabase get instance => _singleton;
  Completer completer = Completer();
  AppDatabase._();
  Future get database async {
    if (!completer.isCompleted) {
      _openDatabase();
    }
    return completer.future;
  }

  Future _openDatabase() async {
    //for platefprm specific directory
    final appDocumentDire = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDire.path, "contacts.db");
    final database = await databaseFactoryIo.openDatabase(dbPath);
    completer.complete(database);
  }
}
