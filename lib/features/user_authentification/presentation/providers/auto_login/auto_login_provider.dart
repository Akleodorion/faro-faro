import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/get_user_info.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/auto_login/state/auto_login_notifier.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/auto_login/state/auto_login_state.dart';
import 'package:faro_clean_tdd/injection_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final autoLoginProvider =
    StateNotifierProvider<AutoLoginNotifier, AutoLoginState>(
  (ref) {
    final GetUserInfo getUserInfoUsecase = sl<GetUserInfo>();
    return AutoLoginNotifier(
      getUserInfoUsecase: getUserInfoUsecase,
    );
  },
);

final autoLoginInfoProvider = Provider<Map>((ref) {
  final state = ref.watch(autoLoginProvider);
  if (state is Loaded) {
    return state.userInfo;
  }

  return {};
});
