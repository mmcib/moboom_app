import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/core/presentation/bloc/get_data_state.dart';
import 'package:moboom_app/core/usecases/usecases.dart';
import 'package:moboom_app/features/comments/data/models/comment_model.dart';
import 'package:moboom_app/features/comments/domain/usecases/get_comments_use_case.dart';
import 'package:moboom_app/features/comments/presentation/cubit/comments_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCommentsUseCase extends Mock implements GetCommentsUseCase {}

void main() {
  late MockGetCommentsUseCase mockGetCommentsUseCase;

  final serverFailure = ServerFailure(
    statusCode: 404,
    errorMessage: 'Sample error message',
    reason: 'Sample reason',
  );

  final clientFailure = ClientFailure(
    Exception('Custom exception'),
    reason: 'Test reason',
  );

  final noInternetConnectionFailure = NoInternetConnectionFailure();

  final mockedComments = [
    CommentModel(
      postId: 1,
      id: 1,
      name: 'Jack',
      email: 'jack@mail.com',
      body: 'Sample body 1',
    ),
    CommentModel(
      postId: 2,
      id: 2,
      name: 'Ann',
      email: 'ann@mail.com',
      body: 'Sample body 2',
    ),
  ];

  setUp(() {
    mockGetCommentsUseCase = MockGetCommentsUseCase();
    registerFallbackValue(NoParams());
  });

  group('CommentsCubit', () {
    test('initial state is GetDataState.initial', () {
      expect(CommentsCubit(mockGetCommentsUseCase).state,
          equals(const GetDataState<List<CommentModel>>.initial()));
    });

    blocTest<CommentsCubit, GetDataState<List<CommentModel>>>(
      'emits [GetDataState.inProgress, GetDataState.success] when loadComments is successful',
      setUp: () => when(() => mockGetCommentsUseCase.execute(any()))
          .thenAnswer((_) async => Right(mockedComments)),
      build: () => CommentsCubit(mockGetCommentsUseCase),
      act: (cubit) => cubit.loadComments(),
      expect: () => [
        const GetDataState<List<CommentModel>>.inProgress(),
        GetDataState<List<CommentModel>>.success(mockedComments),
      ],
    );

    blocTest<CommentsCubit, GetDataState<List<CommentModel>>>(
      'emits [GetDataState.inProgress, GetDataState.failure] when use case returns a ServerFailure',
      setUp: () => when(() => mockGetCommentsUseCase.execute(any()))
          .thenAnswer((_) async => Left(serverFailure)),
      build: () => CommentsCubit(mockGetCommentsUseCase),
      act: (cubit) => cubit.loadComments(),
      expect: () => [
        const GetDataState<List<CommentModel>>.inProgress(),
        GetDataState<List<CommentModel>>.failure(serverFailure),
      ],
    );

    blocTest<CommentsCubit, GetDataState<List<CommentModel>>>(
      'emits [GetDataState.inProgress, GetDataState.failure] when use case returns a ClientFailure',
      setUp: () => when(() => mockGetCommentsUseCase.execute(any()))
          .thenAnswer((_) async => Left(clientFailure)),
      build: () => CommentsCubit(mockGetCommentsUseCase),
      act: (cubit) => cubit.loadComments(),
      expect: () => [
        const GetDataState<List<CommentModel>>.inProgress(),
        GetDataState<List<CommentModel>>.failure(clientFailure),
      ],
    );

    blocTest<CommentsCubit, GetDataState<List<CommentModel>>>(
      'emits [GetDataState.inProgress, GetDataState.failure] when use case returns a NoInternetConnectionFailure',
      setUp: () => when(() => mockGetCommentsUseCase.execute(any()))
          .thenAnswer((_) async => Left(noInternetConnectionFailure)),
      build: () => CommentsCubit(mockGetCommentsUseCase),
      act: (cubit) => cubit.loadComments(),
      expect: () => [
        const GetDataState<List<CommentModel>>.inProgress(),
        GetDataState<List<CommentModel>>.failure(noInternetConnectionFailure),
      ],
    );
  });
}
