import 'package:flutter_test/flutter_test.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/core/usecases/usecases.dart';
import 'package:moboom_app/features/comments/data/models/comment_model.dart';
import 'package:moboom_app/features/comments/domain/repositories/comment_repository.dart';
import 'package:moboom_app/features/comments/domain/usecases/get_comments_use_case.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockCommentRepository extends Mock implements CommentRepository {}

void main() {
  late GetCommentsUseCase getCommentsUseCase;
  late MockCommentRepository mockCommentRepository;

  setUp(() {
    mockCommentRepository = MockCommentRepository();
    getCommentsUseCase = GetCommentsUseCase(mockCommentRepository);
  });

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


  group('test getCommentsUseCase', () {
    test('should get comments from the repository', () async {
      when(() => mockCommentRepository.getComments())
          .thenAnswer(
        (_) async => Right(mockedComments),
      );

      final result = await getCommentsUseCase.execute(NoParams());

      expect(result, Right(mockedComments));
      verify(() => mockCommentRepository
          .getComments()).called(1);
      verifyNoMoreInteractions(mockCommentRepository);
    });

    // ServerFailure
    test('should return failure when repository call is unsuccessful and returns ServerFailure',
        () async {
      when(() => mockCommentRepository.getComments())
          .thenAnswer(
        (_) async => Left(serverFailure),
      );

      final result = await getCommentsUseCase.execute(NoParams());

      expect(result, Left(serverFailure));
      verify(() => mockCommentRepository.getComments()).called(1);
      verifyNoMoreInteractions(mockCommentRepository);
    });

    // ClientFailure
    test(
        'should return failure when repository call is unsuccessful and returns ClientFailure',
        () async {
      when(() => mockCommentRepository.getComments())
          .thenAnswer(
        (_) async => Left(clientFailure),
      );

      final result = await getCommentsUseCase.execute(NoParams());

      expect(result, Left(clientFailure));
      verify(() => mockCommentRepository.getComments()).called(1);
      verifyNoMoreInteractions(mockCommentRepository);
    });

    // NoInternetConnectionFailure
    test('should return failure when repository call is unsuccessful and returns NoInternetConnectionFailure',
        () async {
      when(() => mockCommentRepository.getComments())
          .thenAnswer(
        (_) async => Left(noInternetConnectionFailure),
      );

      final result = await getCommentsUseCase.execute(NoParams());

      expect(result, Left(noInternetConnectionFailure));
      verify(() => mockCommentRepository.getComments()).called(1);
      verifyNoMoreInteractions(mockCommentRepository);
    });
  });
}
