import 'package:elementary_test/elementary_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rim_elementary/features/characters/domain/model/character.dart';
import 'package:rim_elementary/features/common/domain/model/page_result.dart';
import 'package:rim_elementary/presentation/screens/characters_screen/characters_screen.dart';
import 'package:rim_elementary/presentation/screens/characters_screen/characters_screen_model.dart';
import 'package:rim_elementary/presentation/screens/characters_screen/characters_screen_widget_model.dart';

import '../mocks/character_repository_mock.dart';

void main() {
  late CharacterRepositoryMock repository;
  late CharactersModel model;

  CharactersWidgetModel setUpWm() {
    repository = CharacterRepositoryMock();
    model = CharactersModel(repository);

    return CharactersWidgetModel(model);
  }

  Character createCharacter(int id) {
    return Character(
      id: id,
      name: 'Character $id',
      status: 'Alive',
      species: 'Human',
      type: '',
      gender: 'Male',
      image: 'https://example.com/$id.jpg',
      originName: 'Earth',
      originUrl: '',
      locationName: 'Earth',
      locationUrl: '',
      episodeIds: [1, 2, 3],
    );
  }

  PageResult<Character> createPageResult({
    required int page,
    required bool hasNext,
    int itemCount = 20,
  }) {
    return PageResult(
      items: List.generate(itemCount, (i) => createCharacter(page * 20 + i)),
      page: page,
      totalPages: 5,
      hasNext: hasNext,
    );
  }

  group('CharactersWidgetModel', () {
    testWidgetModel<CharactersWidgetModel, CharactersScreen>(
      'loadInitial loads first page',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getCharacters(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: true),
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        expect(wm.charactersState.value.data, isNotNull);
        expect(wm.charactersState.value.data!.length, 20);
        expect(wm.hasNext, true);
        expect(wm.isLoadingMore.value, false);
        expect(wm.hasError.value, false);

        verify(() => repository.getCharacters(1)).called(1);
      },
    );

    testWidgetModel<CharactersWidgetModel, CharactersScreen>(
      'loadMore appends next page',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getCharacters(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: true),
        );
        when(() => repository.getCharacters(2)).thenAnswer(
          (_) async => createPageResult(page: 2, hasNext: false),
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        await wm.loadMore();

        expect(wm.charactersState.value.data!.length, 40);
        expect(wm.hasNext, false);
        expect(wm.isLoadingMore.value, false);

        verify(() => repository.getCharacters(2)).called(1);
      },
    );

    testWidgetModel<CharactersWidgetModel, CharactersScreen>(
      'loadMore stops when hasNext is false',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getCharacters(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: false),
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        await wm.loadMore();

        expect(wm.charactersState.value.data!.length, 20);
        expect(wm.hasNext, false);

        verifyNever(() => repository.getCharacters(2));
      },
    );

    testWidgetModel<CharactersWidgetModel, CharactersScreen>(
      'loadMore sets hasError on exception',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getCharacters(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: true),
        );
        when(() => repository.getCharacters(2)).thenThrow(
          Exception('Network error'),
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        await wm.loadMore();

        expect(wm.hasError.value, true);
        expect(wm.isLoadingMore.value, false);
        expect(wm.charactersState.value.data!.length, 20);
      },
    );

    testWidgetModel<CharactersWidgetModel, CharactersScreen>(
      'refresh resets to page 1',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getCharacters(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: true),
        );
        when(() => repository.getCharacters(2)).thenAnswer(
          (_) async => createPageResult(page: 2, hasNext: true),
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        await wm.loadMore();

        expect(wm.charactersState.value.data!.length, 40);

        when(() => repository.getCharacters(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: true, itemCount: 10),
        );

        await wm.refresh();

        expect(wm.charactersState.value.data!.length, 10);
        expect(wm.hasNext, true);
        expect(wm.hasError.value, false);

        verify(() => repository.getCharacters(1)).called(2);
      },
    );

    testWidgetModel<CharactersWidgetModel, CharactersScreen>(
      'retry reloads current page',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getCharacters(1)).thenThrow(
          Exception('Network error'),
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        expect(wm.hasError.value, true);

        when(() => repository.getCharacters(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: true),
        );

        await wm.retry();

        expect(wm.charactersState.value.data!.length, 20);
        expect(wm.hasError.value, false);

        verify(() => repository.getCharacters(1)).called(2);
      },
    );
  });
}
