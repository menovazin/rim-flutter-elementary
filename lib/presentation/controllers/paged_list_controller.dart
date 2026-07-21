import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';

import '../../features/common/domain/model/page_result.dart';
import '../../services/app_error.dart';
import '../../utils/app_error_utils.dart';

class PagedListController<T> {
  final Future<PageResult<T>> Function(int page) fetch;

  final EntityStateNotifier<List<T>> state = EntityStateNotifier();
  final ValueNotifier<bool> isLoadingMore = ValueNotifier(false);
  final ValueNotifier<AppError?> error = ValueNotifier(null);

  int _currentPage = 1;
  bool _hasNext = true;

  PagedListController({required this.fetch});

  bool get hasNext => _hasNext;

  Future<void> loadInitial() => _loadReplace();

  Future<void> loadMore() async {
    if (!_hasNext || isLoadingMore.value) {
      return;
    }

    isLoadingMore.value = true;
    error.value = null;

    try {
      final result = await fetch(_currentPage);
      final currentItems = state.value.data ?? [];
      state.content([...currentItems, ...result.items]);
      _currentPage = result.page + 1;
      _hasNext = result.hasNext;
    } on Exception catch (e) {
      error.value = resolveAppError(e);
      state.error(e, state.value.data);
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> refresh() async {
    _currentPage = 1;
    _hasNext = true;
    error.value = null;
    isLoadingMore.value = false;
    await _loadReplace();
  }

  Future<void> retry() async {
    error.value = null;
    await _loadReplace();
  }

  Future<void> _loadReplace() async {
    state.loading(state.value.data);

    try {
      final result = await fetch(_currentPage);
      state.content(result.items);
      _currentPage = result.page + 1;
      _hasNext = result.hasNext;
      error.value = null;
    } on Exception catch (e) {
      error.value = resolveAppError(e);
      state.error(e, state.value.data);
    }
  }

  void dispose() {
    state.dispose();
    isLoadingMore.dispose();
    error.dispose();
  }
}
