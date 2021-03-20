part of 'sqlite_cubit.dart';

enum SqliteStates {
  SqliteInitial,
  SqliteReady,
}

abstract class SqliteState extends Equatable {
  final SqliteStates sqliteState;
  const SqliteState(this.sqliteState);

  @override
  List<Object> get props => [sqliteState];
}

class SqliteInitial extends SqliteState {
  const SqliteInitial() : super(SqliteStates.SqliteInitial);
}

class SqliteReady extends SqliteState {
  const SqliteReady() : super(SqliteStates.SqliteReady);
}
