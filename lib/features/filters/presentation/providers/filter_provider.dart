import 'package:faro_clean_tdd/features/filters/domain/usecases/toggle_filter.dart';
import 'package:faro_clean_tdd/features/filters/presentation/providers/state/filter_notifier.dart';
import 'package:faro_clean_tdd/features/filters/presentation/providers/state/filter_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection_container.dart';

final filterProvider =
    StateNotifierProvider<FilterNotifier, FilterState>((ref) {
  final ToggleFilter toggleFilter = sl<ToggleFilter>();

  return FilterNotifier(toggleFilterUsecase: toggleFilter);
});
