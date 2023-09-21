import 'package:faro_clean_tdd/features/category_filter/domain/usecases/toggle_category_filter.dart';
import 'package:faro_clean_tdd/features/category_filter/presentation/providers/state/filter_notifier.dart';
import 'package:faro_clean_tdd/features/category_filter/presentation/providers/state/filter_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection_container.dart';

final filterProvider =
    StateNotifierProvider<FilterNotifier, FilterState>((ref) {
  final ToggleCategoryFilter toggleFilter = sl<ToggleCategoryFilter>();

  return FilterNotifier(toggleFilterUsecase: toggleFilter);
});
