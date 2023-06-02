  import 'package:mysql1/mysql1.dart';

  class Mysql {
    Mysql();

    Future<MySqlConnection> getConnection() async {
      var settings = ConnectionSettings(
          host: "sql8.freesqldatabase.com",
          port: 3306,
          user: "sql8622986",
          password: "ukMUC31KNR",
          db: "sql8622986"
          );

      return await MySqlConnection.connect(settings);
    }
  }