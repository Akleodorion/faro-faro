import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/core/network/network_info.dart';
import 'package:faro_clean_tdd/features/members/data/datasources/member_remote_data_source.dart';
import 'package:faro_clean_tdd/features/members/data/models/member_model.dart';
import 'package:faro_clean_tdd/features/members/data/repositories/member_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'member_repository_impl_test.mocks.dart';

@GenerateMocks([
  NetworkInfo,
  MemberRemoteDataSource,
])
void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockMemberRemoteDataSource mockMemberRemoteDataSource;
  late MemberRepositoryImpl sut;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockMemberRemoteDataSource = MockMemberRemoteDataSource();
    sut = MemberRepositoryImpl(
        networkInfo: mockNetworkInfo,
        remoteDataSource: mockMemberRemoteDataSource);
  });

  group(
    "createMember",
    () {
      const tEventId = 1;
      const tUserId = 1;

      group(
        "when there is no internet connexion",
        () {
          test(
            "should return a Server Failure",
            () async {
              //arrange
              when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
              //act
              final result =
                  await sut.createMember(eventId: tEventId, userId: tUserId);
              //assert
              expect(result,
                  const Left(ServerFailure(errorMessage: noInternetConnexion)));
            },
          );
        },
      );

      group(
        "when there is an internet connexion.",
        () {
          setUp(() => when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => true));

          const tMemberModel =
              MemberModel(id: 1, userId: tEventId, eventIid: tUserId);
          test(
            "should return a Right Member model when the call is successfull",
            () async {
              //arrange
              when(mockMemberRemoteDataSource.createMember(
                      eventId: anyNamed("eventId"), userId: anyNamed("userId")))
                  .thenAnswer((_) async => tMemberModel);
              //act
              final result =
                  await sut.createMember(eventId: tEventId, userId: tUserId);
              //assert
              verify(mockMemberRemoteDataSource.createMember(
                      eventId: tEventId, userId: tUserId))
                  .called(1);
              expect(result, const Right(tMemberModel));
            },
          );

          test(
            "should return a ServerFailure on Exception",
            () async {
              //arrange
              when(mockMemberRemoteDataSource.createMember(
                      eventId: anyNamed("eventId"), userId: anyNamed("userId")))
                  .thenThrow(ServerException(errorMessage: 'oops'));
              //act
              final result =
                  await sut.createMember(eventId: tEventId, userId: tUserId);
              //assert
              verify(mockMemberRemoteDataSource.createMember(
                      eventId: tEventId, userId: tUserId))
                  .called(1);
              expect(result, const Left(ServerFailure(errorMessage: 'oops')));
            },
          );
        },
      );
    },
  );

  group(
    "deleteMember",
    () {
      const int tMemberId = 1;
      group(
        "when there is no internet connexion",
        () {
          test(
            "should return a Server Failure",
            () async {
              //arrange
              when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
              //act
              final result = await sut.deleteMember(memberId: tMemberId);
              //assert
              verify(mockNetworkInfo.isConnected).called(1);
              expect(result,
                  const ServerFailure(errorMessage: noInternetConnexion));
            },
          );
        },
      );

      group('when there is an internet connexion.', () {
        setUp(() =>
            when(mockNetworkInfo.isConnected).thenAnswer((_) async => true));
        test(
          "should return null if the call is successful",
          () async {
            //arrange
            when(mockMemberRemoteDataSource.deleteMember(memberId: tMemberId))
                .thenAnswer((_) async => null);
            //act
            final result = await sut.deleteMember(memberId: tMemberId);
            //assert
            verify(mockMemberRemoteDataSource.deleteMember(memberId: tMemberId))
                .called(1);
            expect(result, null);
          },
        );

        test(
          "should return a ServerFailure is the call throw an error",
          () async {
            //arrange
            when(mockMemberRemoteDataSource.deleteMember(memberId: tMemberId))
                .thenThrow(ServerException(errorMessage: 'oops'));
            //act
            final result = await sut.deleteMember(memberId: tMemberId);
            //assert
            verify(mockMemberRemoteDataSource.deleteMember(memberId: tMemberId))
                .called(1);
            expect(result, const ServerFailure(errorMessage: 'oops'));
          },
        );
      });
    },
  );

  group(
    "fetchMembers",
    () {
      const tUserId = 1;

      group(
        "when there is no internet connexion.",
        () {
          setUp(() =>
              when(mockNetworkInfo.isConnected).thenAnswer((_) async => false));
          test(
            "should return a ServerFailure",
            () async {
              //act
              final result = await sut.fetchMembers(userId: tUserId);
              //assert
              verify(mockNetworkInfo.isConnected);
              expect(result,
                  const Left(ServerFailure(errorMessage: noInternetConnexion)));
            },
          );
        },
      );

      group(
        "when there is an internet connexion.",
        () {
          setUp(() =>
              when(mockNetworkInfo.isConnected).thenAnswer((_) async => true));

          const tMember1 = MemberModel(id: 1, userId: 1, eventIid: 2);
          const tMember2 = MemberModel(id: 2, userId: 2, eventIid: 2);
          const List<MemberModel> tMembers = [tMember1, tMember2];

          test(
            "should return a valid List of Members if the call is successfull",
            () async {
              //arrange
              when(mockMemberRemoteDataSource.fetchMembers(
                      userId: anyNamed("userId")))
                  .thenAnswer((_) async => tMembers);
              //act
              final result = await sut.fetchMembers(userId: tUserId);
              //assert
              expect(result, const Right(tMembers));
            },
          );

          test(
            "should return Server Failure if the call is unsuccessfull",
            () async {
              //arrange
              when(mockMemberRemoteDataSource.fetchMembers(
                      userId: anyNamed("userId")))
                  .thenThrow(ServerException(errorMessage: 'oops'));
              //act
              final result = await sut.fetchMembers(userId: tUserId);
              //assert
              expect(result, const Left(ServerFailure(errorMessage: 'oops')));
            },
          );
        },
      );
    },
  );
}
