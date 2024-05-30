// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/user_authentification/domain/repositories/user_authentification_repository.dart';
import 'package:faro_faro/features/user_authentification/domain/usecases/log_user_out.dart';
import 'log_user_out_test.mocks.dart';

@GenerateMocks([UserAuthentificationRepository])
void main() {
  late MockUserAuthentificationRepository mockUserAuthentificationRepository;
  late LogUserOutUsecase sut;

  setUp(() {
    mockUserAuthentificationRepository = MockUserAuthentificationRepository();
    sut = LogUserOutUsecase(repository: mockUserAuthentificationRepository);
  });

  group(
    "execute",
    () {
      const String tJwt = "Bearer jxljgkfdljgklfdjgklfd";
      test(
        "should return null if the call is successfull",
        () async {
          //arrange
          when(mockUserAuthentificationRepository.logUserOut(
                  jwt: anyNamed('jwt')))
              .thenAnswer((realInvocation) async => null);
          //act
          final result = await sut.execute(jwt: tJwt);
          //assert
          verify(mockUserAuthentificationRepository.logUserOut(jwt: tJwt))
              .called(1);
          expect(result, null);
        },
      );

      test(
        "should return failure if the call is unsuccessfull",
        () async {
          //arrange
          when(mockUserAuthentificationRepository.logUserOut(
                  jwt: anyNamed('jwt')))
              .thenAnswer((realInvocation) async =>
                  const ServerFailure(errorMessage: "oops"));
          //act
          final result = await sut.execute(jwt: tJwt);
          //assert
          verify(mockUserAuthentificationRepository.logUserOut(jwt: tJwt))
              .called(1);
          expect(result, const ServerFailure(errorMessage: "oops"));
        },
      );
    },
  );
}
