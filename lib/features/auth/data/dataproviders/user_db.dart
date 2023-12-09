import 'package:moboom_app/core/data/database/moboom_database.dart';

abstract class UsersDatabase {
  Future<int> insertUser(UserTableCompanion companion);

  Future<List<User>> getUserEntries();
  // Future<User> getUserEntry();
  //
  // Future<void> removeQuote(String quoteId);
  //
  // Future<void> removeAllQuotes();
}
