import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:quests_api/apis/quests_api.dart';
import 'package:quests_api/models/enums.dart';
import 'package:quests_api/models/quest.dart';

void main() {
  //setup
  Hive.init('/test-box');

  final testObjects = [
    Quest(title: 'quest 0', repeat: Repeat.daily, detail: 'quest 0 detail'),
    Quest(title: 'quest 1', repeat: Repeat.weekly, difficulty: Difficulty.hard),
    Quest(title: 'quest 2', repeat: Repeat.monthly, stat: Stat.mental),
  ];

  group('test CRUD quests', () {
    late QuestsApi api;
    setUpAll(() async {
      api = await QuestsApi.create();
      print('set up all');
    });

    setUp(() {
      print('set up');
      return Future(() async {
        await api._box.clear().then((value) => print('setting upupup'));
        print('done setting up');
        return;
      });
    });

    test('Add new quests matching hive key', () async {
      await api.saveQuest(testObjects[0]);
      await api.saveQuest(testObjects[1]);
      await api.saveQuest(testObjects[2]);

      expect(api._box.get(testObjects[0].id), equals(testObjects[0]));
      expect(api._box.get(testObjects[1].id), equals(testObjects[1]));
      expect(api._box.get(testObjects[2].id), equals(testObjects[2]));
      print('run test 1');
    });
    test('Subscript quests stream', () {
      var valueStream = api.getQuestsStream();
      expectLater(
          valueStream,
          emitsInOrder(
            [
              [],
              unorderedEquals([testObjects[0]]),
              unorderedEquals([testObjects[0], testObjects[1]]),
            ],
          ));
      api.saveQuest(testObjects[0]);
      api.saveQuest(testObjects[1]);
    });

    tearDown(() {
      return Future(() async {
        await api._box.clear();
        print('done tearing all down');
        return;
      });
    });

    tearDownAll(() {
      print('tear down all');
    });
  });
}
