import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart';

class LogUserOutUsecase {
  final UserAuthentificationRepository repository;

  LogUserOutUsecase({required this.repository});

  Future<Failure?> execute({required String jwt}) async {
    return repository.logUserOut(jwt: jwt);
  }
}
