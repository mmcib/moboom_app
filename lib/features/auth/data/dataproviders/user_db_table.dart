import 'package:drift/drift.dart';

@DataClassName('User')
class UserTable extends Table {
  TextColumn get id => text().nullable()();

  TextColumn get email => text().nullable()();

  TextColumn get password => text().nullable()();

  TextColumn get firstName => text().nullable()();

  TextColumn get lastName => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
