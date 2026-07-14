import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../di/di.dart';
import '../../../features/characters/domain/model/character.dart';
import '../../../services/app_error.dart';
import '../../../utils/app_error_utils.dart';
import 'characters_screen.dart';
import 'characters_screen_model.dart';

CharactersWidgetModel charactersWidgetModelFactory(BuildContext context) {
  return CharactersWidgetModel(
    CharactersModel(di.characterRepository),
  );
}

class CharactersWidgetModel
    extends WidgetModel<CharactersScreen, CharactersModel>
    implements ICharactersWidgetModel {
  final _charactersState = EntityStateNotifier<List<Character>>();
  final _loadingMoreState = ValueNotifier<bool>(false);
  final _errorState = ValueNotifier<AppError?>(null);
  int _currentPage = 1;
  bool _hasNext = true;

  @override
  EntityValueListenable<List<Character>> get charactersState =>
      _charactersState;

  @override
  bool get hasNext => _hasNext;

  @override
  ValueListenable<bool> get isLoadingMore => _loadingMoreState;

  @override
  ValueListenable<AppError?> get error => _errorState;

  CharactersWidgetModel(super._model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    unawaited(_loadCharacters());
  }

  @override
  void dispose() {
    _charactersState.dispose();
    _loadingMoreState.dispose();
    _errorState.dispose();
    super.dispose();
  }

  @override
  Future<void> loadMore() async {
    if (!_hasNext || _loadingMoreState.value) return;

    _loadingMoreState.value = true;
    _errorState.value = null;

    try {
      final result = await model.getCharacters(_currentPage);
      final currentItems = _charactersState.value.data ?? [];
      _charactersState.content([...currentItems, ...result.items]);
      _currentPage = result.page + 1;
      _hasNext = result.hasNext;
    } on Exception catch (e) {
      _errorState.value = resolveAppError(e);
      _charactersState.error(e, _charactersState.value.data);
    } finally {
      _loadingMoreState.value = false;
    }
  }

  @override
  Future<void> refresh() async {
    _currentPage = 1;
    _hasNext = true;
    _errorState.value = null;
    _loadingMoreState.value = false;
    await _loadCharacters();
  }

  @override
  Future<void> retry() async {
    _errorState.value = null;
    await _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    _charactersState.loading(_charactersState.value.data);

    try {
      final result = await model.getCharacters(_currentPage);
      _charactersState.content(result.items);
      _currentPage = result.page + 1;
      _hasNext = result.hasNext;
      _errorState.value = null;
    } on Exception catch (e) {
      _errorState.value = resolveAppError(e);
      _charactersState.error(e, _charactersState.value.data);
    }
  }
}

abstract interface class ICharactersWidgetModel implements IWidgetModel {
  EntityValueListenable<List<Character>> get charactersState;
  bool get hasNext;
  ValueListenable<bool> get isLoadingMore;
  ValueListenable<AppError?> get error;
  Future<void> loadMore();
  Future<void> refresh();
  Future<void> retry();
}