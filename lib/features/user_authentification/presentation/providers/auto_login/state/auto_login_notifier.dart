import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/get_user_info.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/auto_login/state/auto_login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutoLoginNotifier extends StateNotifier<AutoLoginState> {
  AutoLoginNotifier({
    required this.getUserInfoUsecase,
  }) : super(Loading());
  final GetUserInfo getUserInfoUsecase;

  AutoLoginState get initialState => Loading();

  Future<AutoLoginState> getUserInfo() async {
    final response = await getUserInfoUsecase.call();
    state = Loaded(userInfo: response!);
    return state;
  }
}
