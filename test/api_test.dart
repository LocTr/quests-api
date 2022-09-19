import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  test('test db', () async {
    Hive.init('Testbox');
    var box = await Hive.openBox('testBox');
    box.put('0c5a8a87-f707-471d-98ab-096a11bedc9e', 'this');
  });
}
