import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../di/di.dart';
import '../../../features/characters/domain/model/character.dart';
import '../../../routes/router.gr.dart';
import '../../../services/app_error.dart';
import '../../controllers/paged_list_controller.dart';
import 'characters_screen.dart';
import 'characters_screen_model.dart';

CharactersWidgetModel charactersWidgetModelFactory(BuildContext context) {
  return CharactersWidgetModel(
    CharactersModel(di.characterRepository),
    di.appRouter,
  );
}

class CharactersWidgetModel
    extends WidgetModel<CharactersScreen, CharactersModel>
    implements ICharactersWidgetModel {
  final StackRouter _router;
  late final PagedListController<Character> _controller;

  CharactersWidgetModel(super._model, this._router) {
    _controller = PagedListController(fetch: model.getCharacters);
  }

  @override
  EntityValueListenable<List<Character>> get charactersState =>
      _controller.state;

  @override
  bool get hasNext => _controller.hasNext;

  @override
  ValueListenable<bool> get isLoadingMore => _controller.isLoadingMore;

  @override
  ValueListenable<AppError?> get error => _controller.error;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    unawaited(_controller.loadInitial());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Future<void> loadMore() => _controller.loadMore();

  @override
  Future<void> refresh() => _controller.refresh();

  @override
  Future<void> retry() => _controller.retry();

  @override
  void openCharacter(Character character) {
    unawaited(_router.push(CharacterDetailRoute(character: character)));
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
  void openCharacter(Character character);
}
