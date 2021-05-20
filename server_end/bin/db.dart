import 'package:fluent_query_builder/fluent_query_builder.dart';

void main() {
  //PostgreSQL connection information
  final pgsqlCom = DBConnectionInfo(
    host: 'localhost',
    database: 'banco_teste',
    driver: ConnectionDriver.pgsql,
    port: 5432,
    username: 'user',
    password: 'pass',
    charset: 'utf8',
    schemes: ['public'],
  );

  //MySQL connection information
  final mysqlCom = DBConnectionInfo(
    host: 'localhost',
    database: 'test',
    driver: ConnectionDriver.mysql,
    port: 3306,
    username: 'root',
    password: '123456',
    charset: 'utf8',
  );

  DbLayer().connect(mysqlCom).then((db) {
    //mysql insert
    db
        .insert()
        .into('user')
        .set('name', 'liuyuhui')
        .exec()
        .then((result) => print('mysql insert $result'));

    //mysql update
    db
        .update()
        .table('user')
        .set('name', 'yuhui.liu')
        .where('id=?', 1)
        .exec()
        .then((result) => print('mysql update $result'));

    //mysql delete
    db
        .delete()
        .from('user')
        .where('id=?', 2)
        .exec()
        .then((result) => print('mysql delete $result'));

    //mysql raw query SELECT * FROM `pessoas` or SELECT COUNT(*) FROM pessoas
    db
        .raw("SELECT * FROM `user`")
        .exec()
        .then((result) => print('mysql raw $result'));
  });
}
