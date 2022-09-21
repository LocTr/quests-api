import 'package:flutter_test/flutter_test.dart';
import 'package:task_api/task_api.dart';

void main() {
  test('test db', () async {
    TaskApi api = await TaskApi.create();
  });
}
