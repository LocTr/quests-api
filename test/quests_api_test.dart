import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quests_api/apis/quests_api.dart';
import 'package:quests_api/models/enums.dart';
import 'package:quests_api/models/quest.dart';

class MockBox<Quest> extends Mock implements Box<Quest> {}

class MockAdapter extends Mock implements QuestAdapter {}

void main() {
  //setup
  group('QuestsApi', () {
    late Box<Quest> box;

    final quests = [
      Quest(
          title: 'quest 0',
          repeat: Repeat.daily,
          detail: 'quest 0 detail',
          nextResetDate: DateTime.now()),
      Quest(
          title: 'quest 1',
          repeat: Repeat.weekly,
          difficulty: Difficulty.hard,
          nextResetDate: DateTime.now()),
      Quest(
          title: 'quest 2',
          repeat: Repeat.monthly,
          stat: Stat.mental,
          nextResetDate: DateTime.now()),
    ];

    setUp(() {
      box = MockBox<Quest>();
      when(() => box.values).thenReturn(quests);
      when(() => box.watch())
          .thenAnswer((_) => Stream<BoxEvent>.fromIterable([]));
    });

    QuestsApi createSubject() {
      return QuestsApi(box: box);
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
      when(() => box.put(quests[0].id, quests[0]))
          .thenAnswer((_) => Future(() {}));

      final subject = createSubject();

      expect(subject.saveQuest(quests[0]), completes);
      verify(() => box.put(quests[0].id, quests[0])).called(1);
    });

    test('deleteQuest', () {
      when(() => box.delete(quests[0].id)).thenAnswer((_) => Future(() {}));

      final subject = createSubject();

      expect(subject.deleteQuest(quests[0].id), completes);
      verify(() => box.delete(quests[0].id)).called(1);
    });

    test('getQuestsStream returns stream of current quests', () async {
      expect(createSubject().getQuestsStream(), emits(quests));
    });
  });
}
