import 'dart:async';
import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quests_api/apis/quests_api.dart';
import 'package:quests_api/models/enums.dart';
import 'package:quests_api/models/quest.dart';

class MockHive extends Mock implements HiveInterface {}

class MockBox<Quest> extends Mock implements Box<Quest> {}

class MockAdapter extends Mock implements QuestAdapter {}

void main() {
  //setup
  group('QuestsApi', () {
    late HiveInterface hive;
    late Box<Quest> box;

    final quests = [
      Quest(title: 'quest 0', repeat: Repeat.daily, detail: 'quest 0 detail'),
      Quest(
          title: 'quest 1', repeat: Repeat.weekly, difficulty: Difficulty.hard),
      Quest(title: 'quest 2', repeat: Repeat.monthly, stat: Stat.mental),
    ];

    setUp(() {
      hive = MockHive();
      box = MockBox<Quest>();
      when(() => box.values).thenReturn(quests);
      when(() => box.watch())
          .thenAnswer((_) => Stream<BoxEvent>.fromIterable([]));
    });

    QuestsApi createSubject() {
      return QuestsApi(box: box, hiveInterface: hive);
    }

    group('constructor', () {
      test('works properly', () {
        expect(createSubject, returnsNormally);
      });
    });

    group('initialize quests stream', () {
      test('with existing quests if present', () {
        final subject = createSubject();

        expect(subject.getQuestsStream(), emits(quests));
        verify(() => box.values).called(1);
      });

      test('with empty if data is empty', () {
        when(() => box.values).thenReturn(const Iterable.empty());
        final subject = createSubject();

        expect(subject.getQuestsStream(), emits(const <Quest>[]));
        verify(() => box.values).called(1);
      });
    });

    test('save quest', () {
      final quest = Quest(title: 'test quest', repeat: Repeat.daily);

      when(() => box.put(quest.id, quest)).thenAnswer((_) => Future(() {}));

      final subject = createSubject();

      expect(subject.saveQuest(quest), completes);
      verify(() => box.put(quest.id, quest)).called(1);
    });

    test('deleteQuest', () {
      final quest = Quest(title: 'test quest', repeat: Repeat.daily);

      when(() => box.delete(quest.id)).thenAnswer((_) => Future(() {}));

      final subject = createSubject();

      expect(subject.deleteQuest(quest.id), completes);
      verify(() => box.delete(quest.id)).called(1);
    });

    test('getQuestsStream returns stream of current quests', () async {
      expect(createSubject().getQuestsStream(), emits(quests));
    });
  });
}
