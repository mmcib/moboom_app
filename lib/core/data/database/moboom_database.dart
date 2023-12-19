import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:moboom_app/features/auth/data/dataproviders/user_db.dart';
import 'package:moboom_app/features/auth/data/dataproviders/user_db_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:path/path.dart' as path;

part 'moboom_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [UserTable])
class MoboomDatabase extends _$MoboomDatabase implements UsersDatabase {
  @visibleForTesting
  MoboomDatabase(QueryExecutor executor) : super(executor);

  factory MoboomDatabase.initialize() => MoboomDatabase(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator migration) => migration.createAll(),
        onUpgrade: (Migrator migration, int from, int to) async {},
      );

  /// Users Table
  @override
  Future<List<User>> getUserEntries() => select(userTable).get();

  Future<User?> getUserEntry(String email, String password) =>
      (select(userTable)
            ..where(
              (it) => it.email.equals(email) & it.password.equals(password),
            ))
          .getSingleOrNull();

  @override
  Future<int> insertUser(UserTableCompanion companion) {
    return into(userTable).insertOnConflictUpdate(
      _mapUserToInsertCompanion(companion),
    );
  }

  UserTableCompanion _mapUserToInsertCompanion(UserTableCompanion user) {
    return UserTableCompanion.insert(
      id: user.id,
      email: user.email,
      password: user.password,
      firstName: user.firstName,
      lastName: user.lastName,
    );
  }
}
