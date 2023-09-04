import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart';

class GetUserInfo {
  GetUserInfo({required this.repository});

  final UserAuthentificationRepository repository;

  Future<Map<String, dynamic>?> call() async {
    return repository.getUserInfo();
  }
}
