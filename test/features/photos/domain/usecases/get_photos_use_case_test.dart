import 'package:flutter_test/flutter_test.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/core/usecases/usecases.dart';
import 'package:moboom_app/features/photos/data/models/photo_model.dart';
import 'package:moboom_app/features/photos/domain/repositories/photo_repository.dart';
import 'package:moboom_app/features/photos/domain/usecases/get_photos_use_case.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockPhotoRepository extends Mock implements PhotoRepository {}

void main() {
  late GetPhotosUseCase getPhotosUseCase;
  late MockPhotoRepository mockPhotoRepository;

  setUp(() {
    mockPhotoRepository = MockPhotoRepository();
    getPhotosUseCase = GetPhotosUseCase(mockPhotoRepository);
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
  
  final mockedPhotos = [
    PhotoModel(
      albumId: 1,
      id: 1,
      title: 'title1',
      url: 'https://photos.com/1/full',
      thumbnailUrl: 'https://photos.com/1/thumbnail',
    ),
    PhotoModel(
      albumId: 2,
      id: 2,
      title: 'title2',
      url: 'https://photos.com/2/full',
      thumbnailUrl: 'https://photos.com/2/thumbnail',
    ),
  ];

  group('test getPhotosUseCase', () {
    test('should get photos from the repository', () async {
      when(() => mockPhotoRepository.getPhotos())
          .thenAnswer(
        (_) async => Right(mockedPhotos),
      );

      final result = await getPhotosUseCase.execute(NoParams());

      expect(result, Right(mockedPhotos));
      verify(() => mockPhotoRepository
          .getPhotos()).called(1);
      verifyNoMoreInteractions(mockPhotoRepository);
    });

    // ServerFailure
    test('should return failure when repository call is unsuccessful and returns ServerFailure',
        () async {
      when(() => mockPhotoRepository.getPhotos())
          .thenAnswer(
        (_) async => Left(serverFailure),
      );

      final result = await getPhotosUseCase.execute(NoParams());

      expect(result, Left(serverFailure));
      verify(() => mockPhotoRepository.getPhotos()).called(1);
      verifyNoMoreInteractions(mockPhotoRepository);
    });

    // ClientFailure
    test(
        'should return failure when repository call is unsuccessful and returns ClientFailure',
        () async {
      when(() => mockPhotoRepository.getPhotos())
          .thenAnswer(
        (_) async => Left(clientFailure),
      );

      final result = await getPhotosUseCase.execute(NoParams());

      expect(result, Left(clientFailure));
      verify(() => mockPhotoRepository.getPhotos()).called(1);
      verifyNoMoreInteractions(mockPhotoRepository);
    });

    // NoInternetConnectionFailure
    test('should return failure when repository call is unsuccessful and returns NoInternetConnectionFailure',
        () async {
      when(() => mockPhotoRepository.getPhotos())
          .thenAnswer(
        (_) async => Left(noInternetConnectionFailure),
      );

      final result = await getPhotosUseCase.execute(NoParams());

      expect(result, Left(noInternetConnectionFailure));
      verify(() => mockPhotoRepository.getPhotos()).called(1);
      verifyNoMoreInteractions(mockPhotoRepository);
    });
  });
}
