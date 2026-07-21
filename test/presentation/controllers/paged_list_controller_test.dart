import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/features/common/domain/model/page_result.dart';
import 'package:rim_elementary/presentation/controllers/paged_list_controller.dart';
import 'package:rim_elementary/services/app_error.dart';

void main() {
  PageResult<int> page({
    required int page,
    required List<int> items,
    required bool hasNext,
  }) {
    return PageResult(
      items: items,
      page: page,
      totalPages: 3,
      hasNext: hasNext,
    );
  }

  group('PagedListController', () {
    test('loadInitial fills content', () async {
      final controller = PagedListController<int>(
        fetch: (p) async => page(page: p, items: [1, 2], hasNext: true),
      );

      await controller.loadInitial();

      expect(controller.state.value.data, [1, 2]);
      expect(controller.hasNext, true);
      expect(controller.error.value, isNull);

      controller.dispose();
    });

    test('loadMore appends items', () async {
      final controller = PagedListController<int>(
        fetch: (p) async {
          if (p == 1) {
            return page(page: 1, items: [1], hasNext: true);
          }
          return page(page: 2, items: [2], hasNext: false);
        },
      );

      await controller.loadInitial();
      await controller.loadMore();

      expect(controller.state.value.data, [1, 2]);
      expect(controller.hasNext, false);

      controller.dispose();
    });

    test('refresh resets to first page', () async {
      final controller = PagedListController<int>(
        fetch: (p) async {
          if (p == 1) {
            return page(page: 1, items: [1, 2], hasNext: true);
          }
          return page(page: 2, items: [3], hasNext: true);
        },
      );

      await controller.loadInitial();
      await controller.loadMore();
      expect(controller.state.value.data, [1, 2, 3]);

      await controller.refresh();
      expect(controller.state.value.data, [1, 2]);

      controller.dispose();
    });

    test('loadInitial maps AppException to error', () async {
      final controller = PagedListController<int>(
        fetch: (_) async => throw AppException(const AppError.network()),
      );

      await controller.loadInitial();

      expect(controller.error.value, const AppError.network());
      expect(controller.state.value.isErrorState, isTrue);

      controller.dispose();
    });
  });
}
