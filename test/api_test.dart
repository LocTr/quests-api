import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:tasks_api/tasks_api.dart';

void main() {
  test('test db', () async {
    TaskApi api = await TaskApi.create(Hive.init('asdfasdf'));
  });
}
