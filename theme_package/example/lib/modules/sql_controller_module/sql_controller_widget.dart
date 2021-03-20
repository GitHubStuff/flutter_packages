import 'package:template/modules/sql_controller_module/cubit/sqlite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqlite_package/sqlite_package.dart' as SQL;
import 'package:theme_package/theme_package.dart';

import 'sql_controller_module.dart';

class SqlControllerWidget extends ModularStatelessWidget<SqlControllerModule> {
  static const String route = '/SqlControllerWidget';

  @override
  Widget build(BuildContext context) {
    final sqliteCubit = Modular.get<SqliteCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text('SqliteWidget'),
      ),
      body: Center(
        child: BlocProvider(
          create: (providerContext) => sqliteCubit,
          child: BlocBuilder<SqliteCubit, SqliteState>(builder: (_, state) {
            switch (state.sqliteState) {
              case SqliteStates.SqliteInitial:
                sqliteCubit.setUp();
                return Container(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                );
              case SqliteStates.SqliteReady:
                _buildDatabase();
                break;
            }
            return Container(
              child: Text('DONE WITH USELESS DATABASE SETUP'),
            );
          }),
        ),
      ),
    );
  }

  //MARK: Creates a really useless collection of tables to serve as a guide for sqlite development
  void _buildDatabase() async {
    try {
      await _buildSiblings();
      await _buildAddress();
      await _buildName();
      await _loading();
      await _getTheColumns();
    } catch (error) {
      Log.E('${error.toString()}');
    }
  }

  Future<void> _buildSiblings() async {
    try {
      final String create = '''
      CREATE TABLE IF NOT EXISTS siblings (
         addressId INTEGER,
         nameId INTEGER,
         PRIMARY KEY (addressId, nameId),
         FOREIGN KEY (addressId)
           REFERENCES address (rowid),
         FOREIGN KEY (nameId)
           REFERENCES name (rowid)
      )
      ''';
      await SQL.SqliteController.database.execute(create);
    } catch (error) {
      Log.E('${error.toString()}');
    }
  }

  Future<void> _buildAddress() async {
    try {
      final String create = '''
      CREATE TABLE IF NOT EXISTS address (
        address TEXT,
        age INTEGER,
        weight REAL,
        dob TEXT,
        name INTEGER,
        FOREIGN KEY (name)
          REFERENCES name (rowId)
      )
      ''';
      await SQL.SqliteController.database.execute(create);
    } catch (error) {
      Log.E('${error.toString()}');
    }
  }

  Future<void> _buildName() async {
    try {
      final String create = '''
      CREATE TABLE IF NOT EXISTS name (
        first TEXT,
        last TEXT
      )
      ''';
      await SQL.SqliteController.database.execute(create);
    } catch (error) {
      Log.E('${error.toString()}');
    }
  }

  Future<void> _loading() async {
    try {
      Map<String, dynamic> name = {'first': 'Steven', 'last': 'Smith'};
      final database = SQL.SqliteController.database;
      int nameRowid = await database.insert('name', name);
      Map<String, dynamic> address = {
        'address': '2526 Orange Tree',
        'age': 59,
        'weight': 209.5,
        'dob': '1960-12-19T19:56:00Z',
        'name': nameRowid,
      };
      int addressId = await database.insert('address', address);
      Map<String, dynamic> brother = {'first': 'Richard', 'last': 'Smith'};
      int broId = await database.insert('name', brother);
      Map<String, dynamic> bro = {'addressId': addressId, 'nameId': broId};
      int broRow = await database.insert('siblings', bro);
      Log.T('broRow $broRow');

      Map<String, dynamic> sister = {'first': 'DeeDee', 'last': 'Grau'};
      int sisId = await database.insert('name', sister);
      Map<String, dynamic> sis = {'addressId': addressId, 'nameId': sisId};
      int sisRow = await database.insert('siblings', sis);
      Log.T('sisRow $sisRow');
      Log.T('Done');
    } catch (error) {
      Log.E('${error.toString()}');
    }
  }

  Future<void> _getTheColumns() async {
    final database = SQL.SqliteController.database;
    final sql = 'PRAGMA table_info(address)';
    List<Map<String, dynamic>> results = await database.rawQuery(sql);
    Log.V('result: ${results.toString()}');
    for (Map<String, dynamic> row in results) {
      final name = row['name'];
      Log.V('name $name');
    }
  }
}
